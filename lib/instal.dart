import 'dart:io';


/// We create this file to create the base file
/// 
void main(List<String> args) {
  File arquivo = File('example/model_develop.dart');

  try {
        var meuModel = 

'''
import 'package:model_develop/model_develop.dart';

void main(List<String> args) {
  ControllerModelDeveloper.init(args);
}
    

    
    ''';
   
    File(arquivo.path).writeAsStringSync(meuModel);
    print('Arquivo criado com sucesso!');
  } catch (e) {
    print('Erro ao criar o arquivo: $e');
  }
}