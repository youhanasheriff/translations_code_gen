String generateDartCode(Map<String, dynamic> data, String type, String lang) {
  if (type == 'keys') {
    return generateDartCodeKeys(data);
  } else if (type == 'values') {
    return generateDartCodeValues(data, lang);
  } else {
    throw Exception('Unknown type: $type');
  }
}

String generateDartCodeKeys(Map<String, dynamic> data) {
  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln(
      '// ignore_for_file: constant_identifier_names, camel_case_types');
  buffer.writeln();

  // Generate the class
  for (var entry in data.entries) {
    buffer.writeln('class ${entry.key} {');

    for (var field in (entry.value as Map<String, dynamic>).entries) {
      buffer.write(
        '  static const String ${field.key} = "${entry.key}.${field.key}";\n',
      );
    }

    buffer.writeln('}');
    buffer.writeln();
  }

  return buffer.toString();
}

String generateDartCodeValues(Map<String, dynamic> data, String lang) {
  final buffer = StringBuffer();
  final entryKeys = [];
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln();
  buffer.writeln("import '../keys.dart';");
  buffer.writeln();

  // Generate the class
  for (var entry in data.entries) {
    buffer.write(
      'const Map<String, String> _${entry.key.toLowerCase()}  = {\n',
    );
    entryKeys.add('_${entry.key.toLowerCase()}');

    for (var field in (entry.value as Map<String, dynamic>).entries) {
      buffer.writeln(
        '  ${entry.key}.${field.key}: "${field.value}",',
      );
    }
    buffer.writeln('};');
    buffer.writeln();
  }

  buffer.writeln('final Map<String, String> ${lang}Values = {');
  for (var entryKey in entryKeys) {
    buffer.writeln('  ...$entryKey,');
  }
  buffer.writeln('};');

  return buffer.toString();
}
