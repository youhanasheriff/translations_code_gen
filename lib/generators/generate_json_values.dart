/// Generates Json Strnig from a [Map] of [String] keys and [dynamic] values.
/// The generated [Map] will have the same keys as the input map,
/// and it will have values that are the concatenation of the key
/// in the input map and the key in the associated value map.
///
/// Example:
/// ```dart
/// final Map<String, dynamic> data = {
/// 'App': {
///     'title': 'Flutter Demo Home Page',
///     'message': 'You have pushed the button this many times:',
///   },
/// };
///
/// final jsonString = generateJsonValues(data, 'en');
///
/// print(jsonString);
/// // {
/// //   "App.title": "Flutter Demo Home Page",
/// //   "App.message": "You have pushed the button this many times:",
/// // }
/// ```
///
String generateJsonValues(Map<String, dynamic> data, String lang) {
  final buffer = StringBuffer();

  // Generate the class
  buffer.writeln('{');
  for (var entry in data.entries) {
    for (var field in (entry.value as Map<String, dynamic>).entries) {
      final isLastLine = entry.key == data.keys.last &&
          field.key == (entry.value as Map<String, dynamic>).keys.last;

      buffer.writeln(
        '  "${entry.key}.${field.key}": "${field.value.replaceAll('"', '\\"').replaceAll('\n', '\\n')}"${isLastLine ? '' : ','}',
      );
    }
  }
  buffer.writeln('}');

  return buffer.toString();
}
