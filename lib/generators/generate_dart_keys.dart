/// Generates a Dart code that defines class constants for keys
/// of a given [Map] of [String] keys to [dynamic] values.
/// The generated class name will be the same as the key in the
/// input map, and it will have constants for each key in its
/// associated value map.
///
/// For keys whose values are strings containing placeholders (positional `{}` or
/// named `{name}`), a static method is generated that calls the `.tr()` extension
/// from easy_localization. Positional placeholders generate a single named
/// parameter `{List<String?>? args}`, and named placeholders generate named
/// parameters (e.g., `{String? name}`). No additional parameters are included.
///
/// The method name is the camelCase version of the constant name.
///
/// The generated code includes a header indicating that it was
/// auto-generated, and it includes the necessary ignore directives
/// to avoid linter warnings for constant_identifier_names and
/// camel_case_types. It imports `easy_localization` only if methods are generated.
///
/// The returned [String] contains the generated Dart code.
///
/// Example:
/// ```dart
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

/// Converts a string to camelCase.
/// Example: MY_NAME_IS_ -> myNameIs
String _toCamelCase(String input) {
  final parts =
      input.toLowerCase().split('_').where((part) => part.isNotEmpty).toList();
  return parts.asMap().entries.map((e) {
    final word = e.value;
    if (e.key == 0) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join();
}
