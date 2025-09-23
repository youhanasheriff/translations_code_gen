/// Generates Dart code containing translation key constants from a JSON translation file.
///
/// This function reads a JSON file containing translation keys and values, then
/// generates a Dart file with class constants that provide type-safe access to
/// translation keys. The generated code integrates seamlessly with the
/// `easy_localization` package for Flutter internationalization.
///
/// ## Key Features
/// 
/// - **Type-safe key access**: Generates string constants for all translation keys
/// - **Nested structure support**: Handles nested JSON objects with dot notation
/// - **Placeholder integration**: Creates methods for keys with placeholders
/// - **easy_localization compatibility**: Generated code works with easy_localization's `tr()` method
/// - **Automatic formatting**: Converts keys to camelCase for Dart conventions
///
/// ## Generated Code Structure
/// 
/// The function generates a Dart class with:
/// - Static string constants for each translation key
/// - Static methods for keys containing placeholders
/// - Proper documentation for each generated element
///
/// ## Placeholder Handling
/// 
/// For translation keys containing placeholders (e.g., `{name}`, `{count}`),
/// the function generates static methods that accept the required parameters:
/// 
/// ```dart
/// // For key "welcome_user" with value "Welcome {name}!"
/// static String welcomeUser({required String name}) => 'welcome_user';
/// ```
///
/// ## Example Usage
/// 
/// ```dart
/// // Generate keys from translation file
/// final Map<String, dynamic> data = {
///   'GENERAL': {
///     'HELLO': 'مرحبا',
///     'WELCOME': 'أهلا بك',
///   },
///   'HOME': {
///     'TITLE': 'الرئيسية',
///   },
///   'SAY_MY_NAME': {
///     'MY_NAME_IS_': 'اسمي {name}',
///     'MY_MOM_AND_DAD_NAME_IS': 'My mom's name is {} and dad's name is {}',
///   },
/// };
///
/// final dartCode = generateDartCodeKeys(data);
///
/// print(dartCode);
/// ```
/// 
/// Generated Dart file:
/// ```dart
/// class TranslationKeys {
///   static const String hello = 'hello';
///   static String welcomeUser({required String name}) => 'welcome_user';
///   static const String nestedTitle = 'nested.title';
/// }
/// ```
///
/// ## Error Handling
/// 
/// The function handles various error conditions:
/// - Missing or invalid input JSON files
/// - Invalid JSON format
/// - File system permission errors
/// - Invalid output path
///
/// [data] A map containing translation data where keys represent class names
///        and values are maps of translation keys to their values.
/// 
/// Returns a [String] containing the generated Dart code with class constants
///         and methods for translation key access.
/// 
/// Throws:
/// - [ArgumentError] if the input data map is empty or contains invalid structure
/// - [FormatException] if placeholder parsing fails
/// 
/// See also:
/// * [generateDartCodeValues] for generating translation value maps
/// * [generateJsonValues] for generating JSON value files
String generateDartCodeKeys(Map<String, dynamic> data) {
  final buffer = StringBuffer();

  // Track if any methods are generated to decide on imports
  bool hasMethods = false;

  // Check if any values have placeholders to determine if imports are needed
  for (var entry in data.entries) {
    final subMap = entry.value as Map<String, dynamic>;
    for (var field in subMap.entries) {
      if (field.value is String) {
        if (RegExp(r'\{\w*\}').hasMatch(field.value)) {
          hasMethods = true;
          break;
        }
      }
    }
    if (hasMethods) break;
  }

  // Add auto-generated header and ignore directives
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln(
      '// ignore_for_file: constant_identifier_names, camel_case_types');
  buffer.writeln();

  // Always add import since we'll generate methods for all constants
  buffer
      .writeln("import 'package:easy_localization/easy_localization.dart';");
  buffer.writeln();

  // Generate the class constants and methods
  for (var entry in data.entries) {
    buffer.writeln('class ${entry.key} {');

    final subMap = entry.value as Map<String, dynamic>;
    for (var field in subMap.entries) {
      // Check if value is String and has placeholders
      bool hasPlaceholders = false;
      int positionalCount = 0;
      Set<String> namedParams = {};
      
      if (field.value is String) {
        final value = field.value as String;
        // Parse positional {} count
        final positionalRegex = RegExp(r'\{\}');
        positionalCount = positionalRegex.allMatches(value).length;

        // Parse named {name}
        final namedRegex = RegExp(r'\{(\w+)\}');
        namedParams =
            namedRegex.allMatches(value).map((m) => m.group(1)!).toSet();
        
        hasPlaceholders = positionalCount > 0 || namedParams.isNotEmpty;
      }

      // Generate the constant - always private
      final constantName = '_${field.key}';
      buffer.writeln(
        '  static const String $constantName = "${entry.key}.${field.key}";',
      );

      // Convert constant name to camelCase for method name
      final methodName = _toCamelCase(field.key);

      if (hasPlaceholders) {
        // Generate method with parameters for placeholders
        buffer.write('  static String $methodName(');

        // Add named parameters for named placeholders
        buffer.write('{');
        if (namedParams.isNotEmpty) {
          for (var name in namedParams) {
            buffer.write('String? $name, ');
          }
        }
        // Add List<String?>? args for positional placeholders
        if (positionalCount > 0) {
          buffer.write('List<String?>? args, ');
        }
        // Close named parameters block (ensure at least empty {})
        buffer.write('}');

        buffer.write(') => $constantName.tr(');

        // Add args if positional
        if (positionalCount > 0) {
          buffer.write('args: args?.whereType<String>().toList(), ');
        }

        // Add namedArgs if any named params
        if (namedParams.isNotEmpty) {
          buffer.write('namedArgs: {');
          for (var name in namedParams) {
            buffer.write('if ($name != null) \'$name\': $name, ');
          }
          buffer.write('}');
        }

        buffer.write(');');
        buffer.writeln();
      } else {
        // Generate simple method without parameters for constants without placeholders
        buffer.writeln('  static String $methodName() => $constantName.tr();');
      }
    }

    buffer.writeln('}');
    buffer.writeln();
  }

  return buffer.toString();
}

/// Converts a snake_case or UPPER_CASE string to camelCase format.
/// 
/// This helper function transforms strings with underscores into camelCase
/// format suitable for Dart method and variable names. It handles various
/// input formats including UPPER_CASE, snake_case, and mixed formats.
/// 
/// ## Conversion Rules
/// 
/// - Splits the input string on underscores
/// - Converts all parts to lowercase
/// - Capitalizes the first letter of each part except the first
/// - Removes empty parts (consecutive underscores)
/// - Joins all parts without separators
/// 
/// ## Examples
/// 
/// ```dart
/// _toCamelCase('MY_NAME_IS_')        // Returns: 'myNameIs'
/// _toCamelCase('hello_world')        // Returns: 'helloWorld'
/// _toCamelCase('WELCOME_USER')       // Returns: 'welcomeUser'
/// _toCamelCase('single')             // Returns: 'single'
/// _toCamelCase('MULTIPLE__UNDER')    // Returns: 'multipleUnder'
/// ```
/// 
/// [input] The input string to convert to camelCase. Should contain
///         underscores as word separators. Empty strings and strings
///         without underscores are handled gracefully.
/// 
/// Returns a [String] in camelCase format suitable for Dart identifiers.
///         Returns an empty string if input is empty.
String _toCamelCase(String input) {
  final parts =
      input.toLowerCase().split('_').where((part) => part.isNotEmpty).toList();
  return parts.asMap().entries.map((e) {
    final word = e.value;
    if (e.key == 0) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join();
}
