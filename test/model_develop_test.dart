import 'package:flutter_test/flutter_test.dart';
import 'package:model_develop/features/usecases.dart';

void main() {
  Map<String, dynamic> map = {"teste1":"resultado" , "teste2":10, "teste3":{"teste5": 20}};
  test('Verificar a criação das classes', () {
    final response = GeradorModelo.gerarModeloDart('{"teste1":"resultado" , "teste2":"resultado2"}', "TesteModel");

    expect(response, isNotNull);
  });

  test('Verificar tipagem', () {
    List<String> response = [];
    for(var i in map.entries){
      response.add(GetType.getTipoDart(i));
      print("Teste $i com o nome ${i.key} é do tipo ${GetType.getTipoDart(i).toString()} com o valor ${i.value}");
    }
    expect(response, isNotEmpty);
  });

  test('Verificar se está colocando a primeira letra maiuscula', () {
    String response = Capitalize.capitalizeFirstLetter("teste");
    print(response);
    expect(response, "Teste");
  });

  test('Verificar se está criando o fronjson', () {
    List<String> response = [];
    for(var i in map.entries){
      String r = GetFrom.getFromJsonConversion(i);
      response.add(r);
      print(r);
    }
    print(response);
    expect(response, isNotEmpty);
  });

  test('Verificar se está remove o underline e adiciona o camelcase', () {
    String response = ConverterCamelCase.converterCamelCase("teste_nome");
    print(response);
    expect(response, "testeNome");
  });

  test('Verificar se está remove o underline e adiciona o camelcaseeeee', () {
    String response = Capita.capitalize("teste");
    print(response);
    expect(response, "Teste");
  });
}
