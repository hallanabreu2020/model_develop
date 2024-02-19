import 'package:model_develop/features/parser/variable/variable_entity.dart';

class ClassExtractor {
  String name;
  Map<String, VariableEntity> variables;

  ClassExtractor({
    required this.name,
    required this.variables,
  });

  void evaluateFields(Map<String, dynamic> json, VariableEntity Function(MapEntry<String, dynamic> entry) onNull) {
    for (final entry in json.entries) {
      final variable = variables[entry.key] ?? onNull(entry);

      variable.evaluate(entry);

      variables[entry.key] = variable;
    }
  }

  @override
  String toString() {
    return '''

class $name {
  ${variables.values.map((e) => e.toAttribute()).join('\n')}
  
  $name({
    ${variables.values.map((e) => e.toConstructor()).join(',\n    ')}
  });
  
  $name copyWith({
    ${variables.values.map((e) => e.toCopyWithParam()).join(',\n    ')}
  }) {
    return $name(
      ${variables.values.map((e) => e.toCopyWith()).join(',\n      ')}
    );
  }
  
  factory $name.fromJson(Map<String, dynamic> json) {
    return $name(
      ${variables.values.map((e) => e.toFromJson()).join(',\n      ')}
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      ${variables.values.map((e) => e.toMapEntry()).join(',\n      ')}
    };
  }
  
 
}

''';
  }
}
