import 'package:model_develop/features/parser/variable/primary_variable_entity.dart';
import 'package:model_develop/features/parser/variable/variable_entity.dart';

class VariableExtractorService {
  bool useOnlyNum;
  bool forceNullable;
  bool useFinals;

  VariableExtractorService({
    this.useOnlyNum = false,
    this.useFinals = true,
    this.forceNullable = false,
  });

  String _numberType(MapEntry<String, dynamic> entry) {
    if (useOnlyNum) {
      return 'num';
    }

    return entry.value.runtimeType.toString();
  }

  VariableEntity _primaryVariable(MapEntry<String, dynamic> entry) {
    String type = entry.value.runtimeType.toString();

    if (entry.value.runtimeType is num) {
      type = _numberType(entry);
    }

    return PrimaryVariableEntity(
      type: type,
      name: entry.key,
      jsonName: entry.key,
      nullable: forceNullable,
      isFinal: useFinals,
    );
  }

  VariableEntity _nullVariable(MapEntry<String, dynamic> entry) {
    return PrimaryVariableEntity(
      type: 'null',
      name: entry.key,
      jsonName: entry.key,
      nullable: true,
      isFinal: true,
    );
  }

  VariableEntity _getDynamicType(MapEntry<String, dynamic> entry) {
    return PrimaryVariableEntity(
      type: 'dynamic',
      name: entry.key,
      jsonName: entry.key,
      nullable: true,
      isFinal: true,
    );
  }

  VariableEntity getDartType(MapEntry<String, dynamic> entry) {
    if (entry.value == null) {
      return _nullVariable(entry);
    }

    switch (entry.value.runtimeType) {
      case String:
      case bool:
      case num:
      case double:
      case int:
        return _primaryVariable(entry);
      case List:
      case Map:
      default:
        return _getDynamicType(entry);
    }
  }
}
