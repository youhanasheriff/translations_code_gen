import '../constants/constants.dart';

/// Generates Dart code containing translation value maps from structured translation data.
///
/// This function creates Dart code that defines maps of string keys to string values
/// for translation systems. It processes nested translation data and generates
/// efficient runtime lookup structures with proper type safety and organization.
///
/// ## Key Features
///
/// - **Runtime translation lookup**: Generates optimized maps for efficient value retrieval
/// - **Multi-language support**: Creates language-specific value maps
/// - **Nested structure support**: Handles hierarchical translation data
/// - **Type-safe generation**: Produces strongly-typed Dart code
/// - **Memory efficient**: Optimized map structures for runtime performance
/// - **Flexible output modes**: Supports different code generation patterns
///
/// ## Generated Code Structure
///
/// The function generates Dart code with:
/// - Private constant maps for each translation category
/// - A main language-specific map that spreads all category maps
/// - Proper type annotations and const declarations
/// - Auto-generated file headers and linter ignore directives
///
/// ## Generation Modes
///
/// The function supports two generation modes via [generateMode]:
///
/// ### Standard Mode ([SupportedGenerateModes.dart])
/// Uses translation key constants for type-safe access:
/// ```dart
/// const Map<String, String> _app = {
///   App.title: "Flutter Demo Home Page",
///   App.message: "You have pushed the button this many times:",
/// };
/// ```
///
/// ### Values-Only Mode ([SupportedGenerateModes.dartValues])
/// Uses string literals for direct key access:
/// ```dart
/// const Map<String, String> _app = {
///   "App.title": "Flutter Demo Home Page",
///   "App.message": "You have pushed the button this many times:",
/// };
/// ```
///
/// ## Input Data Structure
///
/// The input [data] should be a nested map structure where:
/// - Top-level keys represent translation categories (e.g., 'App', 'User')
/// - Second-level maps contain key-value pairs for translations
///
/// Example input structure:
/// ```dart
/// {
///   'App': {
///     'title': 'Flutter Demo Home Page',
///     'message': 'You have pushed the button this many times:',
///   },
///   'User': {
///     'name': 'Name',
///     'email': 'Email Address',
///   }
/// }
/// ```
///
/// ## Example Usage
///
/// ```dart
/// final Map<String, dynamic> translationData = {
///   'App': {
///     'title': 'Flutter Demo Home Page',
///     'message': 'You have pushed the button this many times:',
///   },
/// };
///
/// // Generate standard mode (with key constants)
/// final dartCode = generateDartCodeValues(translationData, 'en');
/// print(dartCode);
/// // Output:
/// // const Map<String, String> _app = {
/// //   App.title: "Flutter Demo Home Page",
/// //   App.message: "You have pushed the button this many times:",
/// // };
/// //
/// // final Map<String, String> enValues = {
/// //   ..._app,
/// // };
///
/// // Generate values-only mode (with string keys)
/// final dartValuesCode = generateDartCodeValues(
///   translationData,
///   'en',
///   generateMode: SupportedGenerateModes.dartValues
/// );
/// print(dartValuesCode);
/// // Output:
/// // const Map<String, String> _app = {
/// //   "App.title": "Flutter Demo Home Page",
/// //   "App.message": "You have pushed the button this many times:",
/// // };
/// //
/// // final Map<String, String> enValues = {
/// //   ..._app,
/// // };
/// ```
///
/// ## String Escaping
///
/// The function automatically handles string escaping for:
/// - Double quotes: `"` becomes `\"`
/// - Newlines: `\n` becomes `\\n`
///
/// This ensures the generated Dart code is syntactically correct and safe.
///
/// ## Generated File Structure
///
/// The output includes:
/// - Auto-generated file header warning
/// - Linter ignore directives for constant naming
/// - Import statements (in standard mode)
/// - Category-specific private maps
/// - Main language values map
///
/// [data] A nested map containing translation data organized by categories.
///        Each top-level key represents a translation category, and each
///        value should be a Map<String, dynamic> containing the translations.
///
/// [lang] The language identifier used to name the generated values map.
///        The final map will be named `{lang}Values` (e.g., 'en' -> 'enValues').
///
/// [generateMode] The code generation mode that determines the output format.
///               Defaults to [SupportedGenerateModes.dart] for standard mode.
///               Use [SupportedGenerateModes.dartValues] for values-only mode.
///
/// Returns a [String] containing the complete generated Dart code ready to be
///         written to a file or used in code generation pipelines.
///
/// See also:
/// * [SupportedGenerateModes] for available generation modes
/// * Translation key generation functions for creating the corresponding key constants
String generateDartCodeValues(
  Map<String, dynamic> data,
  String lang, {
  String generateMode = SupportedGenerateModes.dart,
}) {
  final isDartValuesOnly = generateMode == SupportedGenerateModes.dartValues;

  final buffer = StringBuffer();
  final entryKeys = [];

  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln();
  if (!isDartValuesOnly) {
    buffer.writeln("import '../keys.dart';");
    buffer.writeln();
  }

  // Generate the class
  for (var entry in data.entries) {
    buffer.write(
      'const Map<String, String> _${entry.key.toLowerCase()}  = {\n',
    );
    entryKeys.add('_${entry.key.toLowerCase()}');

    for (var field in (entry.value as Map<String, dynamic>).entries) {
      final quote = isDartValuesOnly ? '"' : '';
      buffer.writeln(
        '  $quote${entry.key}.${field.key}$quote: "${field.value.replaceAll('"', '\\"').replaceAll('\n', '\\n')}",',
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
