import 'package:model_develop/features/parser/variable/variable_entity.dart';

class PrimaryVariableEntity extends VariableEntity {
  PrimaryVariableEntity({
    required super.type,
    required super.name,
    required super.jsonName,
    required super.nullable,
    required super.isFinal,
  });

  @override
  String toAttribute() {
    final nullableString = nullable ? '?' : '';
    final finalString = isFinal ? 'final ' : '';

    return '$finalString ${type + nullableString} $name';
  }

  @override
  String toConstructor() {
    return 'required this.$name';
  }

  @override
  String toCopyWith() {
    return '$type? $name';
  }

  @override
  String toFromJson() {
    return '$name: json[\'$jsonName\'] as $type,';
  }

  @override
  String toMapEntry() {
    return '"$jsonName": $name,';
  }

  @override
  void evaluate(MapEntry<String, dynamic> entry) {
    if (entry.value == null) {
      nullable = true;
    }

    if (entry.runtimeType.toString() != type) {
      type = 'dynamic';
    }
  }
}

class NumericVariableEntity extends PrimaryVariableEntity {
  NumericVariableEntity({
    required super.type,
    required super.name,
    required super.jsonName,
    required super.nullable,
    required super.isFinal,
  });

  @override
  void evaluate(MapEntry<String, dynamic> entry) {
    if (entry.value == null) {
      nullable = true;
    }

    if (entry.value.runtimeType is int && type == 'int') {
      return;
    }

    if (entry.value.runtimeType is int && type == 'double') {
      type = 'num';
      return;
    }

    if (entry.value.runtimeType is double && type == 'double') {
      return;
    }

    if (entry.value.runtimeType is! num) {
      type = 'dynamic';
    }
  }
}
