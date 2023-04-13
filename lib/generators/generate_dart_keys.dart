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
