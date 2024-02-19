extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String unCapitalize() {
    return "${this[0].toLowerCase()}${substring(1)}";
  }

  String toCamelCase() {
    return splitMapJoin(
      RegExp(r'[_\-.,]'),
      onMatch: (m) => '',
      onNonMatch: (n) => n.capitalize(),
    ).unCapitalize();
  }

  String toPascalCase() {
    return splitMapJoin(
      RegExp(r'[_\-.,]'),
      onMatch: (m) => '',
      onNonMatch: (n) => n.capitalize(),
    );
  }

  String toSnakeCase() {
    return splitMapJoin(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      onMatch: (m) => '_${m.group(1)}',
      onNonMatch: (n) => n,
    ).toLowerCase();
  }
}
