<img src="https://raw.githubusercontent.com/hallanabreu2020/images/main/Group%204.png" />

This package makes it easy to generate templates from JSON files located in your project's "lib" folder. Just place the desired JSON file in the location where you want to create your model, and run the corresponding command. When run, "Model_Develop" automatically searches for .json files in the "lib" folder, extracts their values ​​and creates the corresponding model, significantly simplifying the process.



## At its base, in the same lib layer, there should be a file called model_develop.dart...

```dart
import 'package:model_develop/model_develop.dart';

void main(List<String> args) {
  ControllerModelDeveloper.init(args);
}
```



## ...To run, type "dart model_develop.dart -create", that's all, simply and quickly it creates your model.


```txt

"dart model_develop.dart -create"


```


### Example


# Place this json type file in any folder in your architecture and run the above mentioned command and see the magic.

```json
{
  "usuario": {
    "id": 1,
    "nome": "Alice",
    "idade": 30,
    "endereco": {
      "rua": "Rua 1",
      "cidade": "Cidade A",
      "estado": "Estado X"
    },
    "email": "alice@email.com",
    "telefone": "123-456-7890"
  },
  "outrasInformacoes": {
    "ultimaAtualizacao": "2022-03-01T12:30:45Z",
    "categoriasInteresse": ["Tecnologia", "Viagens", "Esportes"],
    "notas": "Usuário ativo, preferências atualizadas regularmente."
  },
  "historicoCompras": [
    {
      "idCompra": 12345,
      "dataCompra": "2022-02-15T09:45:00Z",
      "itens": [
        {"produto": "Laptop", "quantidade": 1, "precoUnitario": 1200.00},
        {"produto": "Mouse", "quantidade": 2, "precoUnitario": 30.00}
      ],
      "total": 1260.00
    },
    {
      "idCompra": 12346,
      "dataCompra": "2022-03-05T14:20:30Z",
      "itens": [
        {"produto": "Livro", "quantidade": 3, "precoUnitario": 15.00},
        {"produto": "Fones de Ouvido", "quantidade": 1, "precoUnitario": 50.00}
      ],
      "total": 95.00
    }
  ],
  "avisos": [
    {"tipo": "promoção", "mensagem": "Desconto especial na próxima compra!"},
    {"tipo": "anúncio", "mensagem": "Novos produtos em breve. Fique atento!"}
  ]
}


```# model_develop
