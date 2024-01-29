import 'dart:convert';
import 'dart:io';


/// To generate the classes
/// 
class GenerateClasses{
    static void generateInternalClasses(Map<String, dynamic> jsonData, List<String> classesInternas) {
    for (final entry in jsonData.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is Map) {
        final subModelName = '${Capitalize.capitalizeFirstLetter(key)}Model';
        final subModelCode = GeradorModelo.gerarModeloDart(json.encode(value), subModelName);
        classesInternas.add(subModelCode.toString());
      }
    }
  }
}


/// To generate the typings
/// 
class GetType{
    static String getTipoDart(MapEntry<String, dynamic> entry) {
    if (entry.value is String) {
      return 'String';
    } else if (entry.value is int) {
      return 'int';
    } else if (entry.value is double) {
      return 'double';
    } else if (entry.value is bool) {
      return 'bool';
    } else if (entry.value is List) {
      if (entry.value.isNotEmpty) {
        if(entry.value.first is Map){
          return 'List<${ConverterCamelCase.converterCamelCase(Capitalize.capitalizeFirstLetter(entry.key))}Model>';
        }else{
          return 'List<${ConverterCamelCase.converterCamelCase(GetList.getList(entry.value))}>';
        }
      } else {
        return 'List<dynamic>';
      }
    } else if (entry.value is Map) {
      return '${ConverterCamelCase.converterCamelCase(Capitalize.capitalizeFirstLetter(entry.key))}Model';
    }
    return 'dynamic';
  }
}


/// To capitalize the first letter
/// 
class Capitalize{
   static String capitalizeFirstLetter(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}


/// Create from jason
/// 
class GetFrom{
  static  String getFromJsonConversion(MapEntry<String, dynamic> entry) {
    if (entry.value is Map) {
      return '${ConverterCamelCase.converterCamelCase(Capitalize.capitalizeFirstLetter(entry.key))}Model.fromJson(json["${entry.key}"])';
    }else if(entry.value is List){
      return "${ConverterCamelCase.converterCamelCase(GetType.getTipoDart(entry))}.from(json['${entry.key}'].map((x) => x))";
    }
    return 'json["${entry.key}"]';
  }
}


/// Get list
/// 
class GetList{
  static  String getList(List<dynamic> value){
    List<String> l = [];
    for(var i in value){
      if (i is String) {
        l.add('String');
      } else if (i is int) {
        l.add('int');
      } else if (i is double) {
        l.add('double');
      } else if (i is bool) {
        l.add('bool');
      }else if(i is List){
        List e = i;
        l.add("List<${GetList.getList(e)}>");
      }
    }
    var seen = Set<String>();
    List<String> uniquelist = l.where((country) => seen.add(country)).toList();
    if(uniquelist.length == 1){
      return uniquelist.first;
    }else{
      return "dynamic";
    }

  }
}


/// Converter Camel Case
/// 
class ConverterCamelCase{
 static String converterCamelCase(String text) {
  List<String> partes = [];
  if(text.contains("_")){
    partes = text.split('_');
  }else if(text.contains("-")){
    partes = text.split('-');
  }else if(text.contains(".")){
    partes = text.split('.');
  }else if(text.contains(",")){
    partes = text.split(',');
  }else{
    return text;
  }

    if (partes.length > 1) {
      String primeiraParte = partes.removeAt(0);
      partes = partes.map((parte) => Capita.capitalize(parte)).toList();
      return primeiraParte + partes.join();
    }

    return text;
  }
}

class Capita{
  static String capitalize(String palavra) {
    return palavra.isEmpty ? palavra : palavra[0].toUpperCase() + palavra.substring(1);
  }
}


/// Gerador Modelo
/// 
class GeradorModelo {
  static StringBuffer gerarModeloDart(String jsonBody, String nameClasse) {
    final Map<String, dynamic> jsonData = json.decode(jsonBody);

    final StringBuffer buffer = StringBuffer();

    List<String> internalClasses = [];
    GenerateClasses.generateInternalClasses(jsonData, internalClasses);

    Iterable newValue = internalClasses.reversed;
    buffer.writeAll(newValue);

    buffer.writeln('class ${ConverterCamelCase.converterCamelCase(nameClasse)} {');

    List<String> entryValueFirst = [];
    List<String> entryKey = [];

    for (final entry in jsonData.entries) {
      final key = entry.key;
      String getTipoDart = GetType.getTipoDart(entry);
      buffer.writeln('  $getTipoDart ${ConverterCamelCase.converterCamelCase(key)};');
      if(getTipoDart.contains("Model") && getTipoDart.contains("List<")){
        entryValueFirst.add(jsonEncode(entry.value.first));
        entryKey.add("${Capitalize.capitalizeFirstLetter(entry.key)}Model");
      }
    }

    buffer.writeln('\n  ${ConverterCamelCase.converterCamelCase(nameClasse)}({');

    for (final entry in jsonData.entries) {
      final key = entry.key;
      buffer.writeln('    required this.${ConverterCamelCase.converterCamelCase(key)},');
    }

    buffer.writeln('  });');

    buffer.writeln('\n  factory ${ConverterCamelCase.converterCamelCase(nameClasse)}.fromJson(Map<String, dynamic> json) => ${ConverterCamelCase.converterCamelCase(nameClasse)}(');

    for (final entry in jsonData.entries) {
      final key = entry.key;
      buffer.writeln('    ${ConverterCamelCase.converterCamelCase(key)}: ${GetFrom.getFromJsonConversion(entry)},');
    }

    buffer.writeln('  );');

    buffer.writeln('\n  Map<String, dynamic> toJson() => {');

    for (final entry in jsonData.entries) {
      final key = entry.key;
      buffer.writeln('    "$key": ${ConverterCamelCase.converterCamelCase(key)},');
    }

    buffer.writeln('  };');

    buffer.writeln('}\n');

    for(int i = 0 ; i < entryValueFirst.length ; i++){
      buffer.writeln(gerarModeloDart(entryValueFirst[i], entryKey[i]));
    }


    return buffer;
  }
}


/// Find File
/// 
class FindFile{

static List<File> buscarArquivosNoDiretorio(String pathFromTheDirectory, String extension) {
  List<File> filesFound = [];

  try {
      Directory directory = Directory(pathFromTheDirectory);

      if (directory.existsSync()) {
        FindFilesRecursively.buscarArquivosRecursivamente(directory, extension, filesFound);
      } else {
        print('O diretório não existe: $pathFromTheDirectory | The directory does not exist: $pathFromTheDirectory');
      }
    } catch (e) {
      print('Erro ao buscar arquivos: $e | Error when searching for files: $e');
    }

    return filesFound;
  }

}


/// Find Files Recursively
/// 
class FindFilesRecursively{
  static void buscarArquivosRecursivamente(Directory directory, String extension, List<File> filesFound) {
    List<FileSystemEntity> contentDirectory = directory.listSync();

    for (FileSystemEntity element in contentDirectory) {
      if (element is File && element.path.endsWith(extension)) {
        filesFound.add(element);
      } else if (element is Directory) {
        buscarArquivosRecursivamente(element, extension, filesFound);
      }
    }
  }

}

