import 'package:model_develop/features/parser/variable/variable_entity.dart';

class ListVariableEntity extends VariableEntity {
  ListVariableEntity({
    required super.type,
    required super.name,
    required super.jsonName,
    required super.nullable,
    required super.isFinal,
  });

  @override
  String toFromJson() {
    return '$name: (json[\'$jsonName\'] as List).map((e) => e as $type).toList(),';
  }

  @override
  String toMapEntry() {
    return '"$jsonName": $name,';
  }

  @override
  void evaluate(MapEntry<String, dynamic> entry) {
    // TODO: implement evaluate
  }
}
