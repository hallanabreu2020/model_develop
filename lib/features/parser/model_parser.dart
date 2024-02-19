import 'dart:convert';

import 'package:model_develop/features/parser/variable_extractor.dart';

import 'class_extractor.dart';

class ModelParser {
  VariableExtractorService _variableExtractor;
  final JsonDecoder jsonDecoder;

  ModelParser({
    required VariableExtractorService variableExtractorService,
    this.jsonDecoder = const JsonDecoder(),
  }) : _variableExtractor = variableExtractorService;

  set variableExtractorService(VariableExtractorService variableExtractorService) {
    _variableExtractor = variableExtractorService;
  }

  String parseJson(String jsonBody, String className) {
    final dynamic jsonData = json.decode(jsonBody);

    final classExtractor = ClassExtractor(name: className, variables: {});

    if (jsonData is Map<String, dynamic>) {
      classExtractor.evaluateFields(jsonData, _variableExtractor.getDartType);
      return classExtractor.toString();
    }

    for (final item in jsonData) {
      classExtractor.evaluateFields(item, _variableExtractor.getDartType);
    }

    return classExtractor.toString();
  }
}
