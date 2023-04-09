/// Generates a Dart code that defines class constants for keys
/// of a given [Map] of [String] keys to [dynamic] values.
/// The generated class name will be the same as the key in the
/// input map, and it will have constants for each key in its
/// associated value map.
///
/// The generated code includes a header indicating that it was
/// auto-generated, and it includes the necessary ignore directives
/// to avoid linter warnings for constant identifier names and
/// camel case types.
///
/// The returned [String] contains the generated Dart code.
///
/// Example:
/// ```dart
/// final Map<String, dynamic> data = {
///  'App': {
///   'title': 'Flutter Demo Home Page',
///  'message': 'You have pushed the button this many times:',
///   },
/// };
///
/// final dartCode = generateDartCodeKeys(data);
///
/// print(dartCode);
/// // Prints:
/// // class App {
/// //   static const String title = "App.title";
/// //   static const String message = "App.message";
/// // }
/// ```
///
String generateDartCodeKeys(Map<String, dynamic> data) {
  final buffer = StringBuffer();

  // Add auto-generated header and ignore directives
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln(
      '// ignore_for_file: constant_identifier_names, camel_case_types');
  buffer.writeln();

  // Generate the class constants
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

/// Generates a Dart code that defines a [Map] of [String] keys to
/// [String] values for a given [Map] of [String] keys to [dynamic]
/// values.
/// The generated [Map] will have the same keys as the input map,
/// and it will have values that are the concatenation of the key
/// in the input map and the key in the associated value map.
/// The generated [Map] will be assigned to a variable named
/// [lang]Values, where [lang] is the name of the language
/// specified in the input map.
/// The generated code includes a header indicating that it was
/// auto-generated, and it includes the necessary ignore directives
/// to avoid linter warnings for constant identifier names.
/// The returned [String] contains the generated Dart code.
/// Example:
/// ```dart
/// final Map<String, dynamic> data = {
/// 'App': {
///     'title': 'Flutter Demo Home Page',
///     'message': 'You have pushed the button this many times:',
///   },
/// };
///
/// final dartCode = generateDartCodeValues(data, 'en');
///
/// print(dartCode);
/// // Prints:
/// // const Map<String, String> _app  = {
/// //   App.title: "Flutter Demo Home Page",
/// //   App.message: "You have pushed the button this many times:",
/// // };
/// //
/// // final Map<String, String> enValues = {
/// //   ..._app,
/// // };
/// ```
///
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
        '  ${entry.key}.${field.key}: "${field.value.replaceAll('"', '\\"').replaceAll('\n', '\\n')}",',
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
