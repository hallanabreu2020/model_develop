abstract class VariableEntity {
  String type;
  String name;
  String jsonName;
  bool nullable;
  bool isFinal;

  VariableEntity({
    required this.type,
    required this.name,
    required this.jsonName,
    required this.nullable,
    required this.isFinal,
  });

  void evaluate(MapEntry<String, dynamic> entry);

  String toAttribute() {
    final nullableString = nullable ? '?' : '';
    final finalString = isFinal ? 'final ' : '';

    return '$finalString ${type + nullableString} $name;';
  }

  String toConstructor() {
    return 'required this.$name';
  }

  String toCopyWithParam() {
    return '$type? $name';
  }

  String toCopyWith() {
    return '$name: $name ?? this.$name';
  }

  String toFromJson();

  String toMapEntry();
}
