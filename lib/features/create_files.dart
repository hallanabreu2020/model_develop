import 'dart:io';

import 'package:model_develop/features/usecases.dart';

/// This is the main control, to return help or create
///
///
class CreateFiles {
  /// Here is help
  ///
  ///   Como usar:
  ///
  ///    dart 'local_do_arquivo_criado_na_base' -create
  ///
  ///  How to use:
  ///
  ///    dart 'location_of_file_created_in_base' -create
  ///
  static help() {
    print('''










  Como usar:
    dart 'local_do_arquivo_criado_na_base' -create

  How to use:
    dart 'location_of_file_created_in_base' -create 


''');
  }

  /// Here I create the "Model".dart files
  ///
  ///
  static readFiles(String local) async {
    File arquivo = File(local);

    String nameModel = arquivo.toString().split("/").last;

    if (arquivo.existsSync()) {
      try {
        String conteudo = await arquivo.readAsString();

        final codigoModelo = GeradorModelo.gerarModeloDart(
            conteudo, "${Capitalize.capitalizeFirstLetter(nameModel.substring(0, nameModel.length - 5))}Model");

        var meuModel = '''

${codigoModelo.toString()}
    
    ''';

        String path = arquivo.path.substring(0, arquivo.path.length - 5);
        File("${path}_model.dart").writeAsStringSync(meuModel);
        arquivo.delete();
      } catch (e) {
        print('Erro ao ler o arquivo: $e | Error reading file: $e');
      }
    } else {
      print('Arquivo não encontrado. | File not found.');
    }
  }

  /// Here is help
  ///
  ///   Como usar:
  ///
  ///    dart 'local_do_arquivo_criado_na_base' -create
  ///
  ///  How to use:
  ///
  ///    dart 'location_of_file_created_in_base' -create
  ///
  static void meet() {
    String pathFromTheDirectory = 'lib';

    List<File> filesFound = FindFile.buscarArquivosNoDiretorio(pathFromTheDirectory, '.json');

    if (filesFound.isNotEmpty) {
      for (File fileValue in filesFound) {
        CreateFiles.readFiles(fileValue.path);
      }
    } else {
      print('Nenhum arquivo .txt encontrado. | No .json files found.');
    }
  }
}
