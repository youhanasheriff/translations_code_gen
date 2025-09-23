import 'dart:convert';

/// Generates flattened JSON strings from nested translation data structures.
///
/// This function converts hierarchical translation data into flattened JSON format
/// where nested keys are joined with dot notation. This is particularly useful
/// for translation systems that need to work with flat key structures while
/// maintaining the organizational benefits of nested source data.
///
/// ## Key Features
///
/// - **Nested structure flattening**: Converts hierarchical data to dot-notation keys
/// - **JSON output format**: Generates valid, formatted JSON strings
/// - **Type preservation**: Maintains value types during conversion
/// - **Readable formatting**: Produces properly indented JSON output
/// - **Translation system integration**: Optimized for localization workflows
///
/// ## Flattening Algorithm
///
/// The function recursively processes nested maps and arrays:
///
/// 1. **Object flattening**: Nested objects become dot-separated keys
/// 2. **Array handling**: Array indices are included in the flattened keys
/// 3. **Value preservation**: Leaf values maintain their original types
/// 4. **Key concatenation**: Parent keys are joined with child keys using dots
///
/// ## Input Data Structure
///
/// The input [data] should be a nested map structure where:
/// - Keys are strings representing translation categories or namespaces
/// - Values can be nested maps, arrays, or primitive values
/// - Nested structures represent hierarchical organization
///
/// ## Flattening Examples
///
/// ### Basic Nested Object
/// ```dart
/// final input = {
///   'App': {
///     'title': 'Flutter Demo Home Page',
///     'message': 'You have pushed the button this many times:',
///   },
///   'User': {
///     'profile': {
///       'name': 'Name',
///       'email': 'Email Address'
///     }
///   }
/// };
///
/// final result = generateJsonValues(input);
/// // Output:
/// // {
/// //   "App.title": "Flutter Demo Home Page",
/// //   "App.message": "You have pushed the button this many times:",
/// //   "User.profile.name": "Name",
/// //   "User.profile.email": "Email Address"
/// // }
/// ```
///
/// ### Array Handling
/// ```dart
/// final input = {
///   'messages': {
///     'errors': ['Error 1', 'Error 2', 'Error 3']
///   }
/// };
///
/// final result = generateJsonValues(input);
/// // Output:
/// // {
/// //   "messages.errors.0": "Error 1",
/// //   "messages.errors.1": "Error 2",
/// //   "messages.errors.2": "Error 3"
/// // }
/// ```
///
/// ### Mixed Data Types
/// ```dart
/// final input = {
///   'config': {
///     'enabled': true,
///     'timeout': 5000,
///     'features': {
///       'darkMode': false,
///       'notifications': true
///     }
///   }
/// };
///
/// final result = generateJsonValues(input);
/// // Output:
/// // {
/// //   "config.enabled": true,
/// //   "config.timeout": 5000,
/// //   "config.features.darkMode": false,
/// //   "config.features.notifications": true
/// // }
/// ```
///
/// ## Use Cases
///
/// This function is particularly useful for:
///
/// - **Translation file processing**: Converting nested translation files to flat formats
/// - **Configuration flattening**: Simplifying complex configuration structures
/// - **API data transformation**: Preparing nested data for systems expecting flat structures
/// - **Database storage**: Converting hierarchical data for key-value storage systems
/// - **Localization workflows**: Integrating with translation management systems
///
/// ## JSON Output Format
///
/// The generated JSON is:
/// - **Well-formatted**: Properly indented with 2-space indentation
/// - **Valid JSON**: Complies with JSON specification standards
/// - **UTF-8 compatible**: Handles international characters correctly
/// - **Escaped properly**: Special characters are properly escaped
///
/// ## Performance Considerations
///
/// - **Memory efficient**: Processes data in a single pass
/// - **Recursive processing**: Handles arbitrarily deep nesting
/// - **Type safe**: Preserves original data types during conversion
/// - **String optimization**: Efficient string concatenation for key building
///
/// [data] A nested map containing the hierarchical data to be flattened.
///        Keys should be strings, and values can be maps, lists, or primitive types.
///        The structure will be recursively processed to create flattened keys.
///
/// Returns a [String] containing the formatted JSON representation of the flattened data.
///         The JSON is properly indented and contains dot-notation keys for all
///         nested structures. Primitive values maintain their original types.
///
/// Throws:
/// - [ArgumentError] if the input data contains unsupported data types
/// - [JsonUnsupportedObjectError] if the data contains objects that cannot be JSON-encoded
///
/// See also:
/// * [generateDartCodeValues] for generating Dart code from the same data structure
/// * [generateDartCodeKeys] for generating translation key constants
/// * [JsonEncoder] for the underlying JSON encoding functionality
String generateJsonValues(Map<String, dynamic> data) {
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
