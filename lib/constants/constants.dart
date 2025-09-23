/// A collection of supported command-line arguments for the translations code generator.
///
/// This class provides constants for the command-line arguments that can be used
/// to specify the generation mode when running the translations_code_gen tool.
///
/// The supported arguments allow users to control what type of code generation
/// should be performed (Dart keys, Dart values, JSON values, or all).
///
/// Example usage:
/// ```bash
/// # Using short-hand argument
/// dart run translations_code_gen -g=dart-keys
///
/// # Using long-hand argument
/// dart run translations_code_gen --generate=dart-values
/// ```
///
/// See also:
/// * [SupportedGenerateModes] for the available generation mode values
class SupportedArguments {
  /// Creates a new instance of [SupportedArguments].
  ///
  /// This constructor is typically not used directly as this class only
  /// contains static constants.
  const SupportedArguments();

  /// The short-hand command-line argument for specifying generation mode.
  ///
  /// This constant represents the abbreviated form of the generate argument
  /// that can be used in command-line invocations.
  ///
  /// Value: `'-g'`
  ///
  /// Example:
  /// ```bash
  /// dart run translations_code_gen -g=dart
  /// ```
  static const String shortHandGenerate = '-g';

  /// The long-hand command-line argument for specifying generation mode.
  ///
  /// This constant represents the full form of the generate argument
  /// that can be used in command-line invocations for better readability.
  ///
  /// Value: `'--generate'`
  ///
  /// Example:
  /// ```bash
  /// dart run translations_code_gen --generate=dart-keys
  /// ```
  static const String longHandGenerate = '--generate';

  /// A list containing all supported command-line arguments.
  ///
  /// This list includes both the short-hand and long-hand forms of the
  /// generate argument. It is used internally for argument validation
  /// and parsing.
  ///
  /// Contains: `[shortHandGenerate, longHandGenerate]`
  ///
  /// Returns:
  /// A [List<String>] containing `['-g', '--generate']`
  static const List<String> supportedArguments = [
    shortHandGenerate,
    longHandGenerate
  ];
}

/// A collection of supported generation modes for the translations code generator.
///
/// This class defines the various modes in which the translations_code_gen tool
/// can operate. Each mode generates different types of output files based on
/// the input translation files.
///
/// The generation modes control whether to generate:
/// - Dart key constants and value maps (full generation)
/// - Only Dart key constants
/// - Only Dart value maps
/// - Only JSON value files
///
/// Example usage:
/// ```bash
/// # Generate both keys and values
/// dart run translations_code_gen --generate=dart
///
/// # Generate only key constants
/// dart run translations_code_gen --generate=dart-keys
///
/// # Generate only value maps
/// dart run translations_code_gen --generate=dart-values
///
/// # Generate JSON value files
/// dart run translations_code_gen --generate=json-values
/// ```
///
/// See also:
/// * [SupportedArguments] for the command-line arguments used with these modes
class SupportedGenerateModes {
  /// The default generation mode that creates both Dart keys and values.
  ///
  /// This mode generates:
  /// - Dart key constants with static methods for easy_localization integration
  /// - Dart value maps for all supported languages
  ///
  /// Value: `'dart'`
  ///
  /// This is the most comprehensive generation mode and is recommended
  /// for most use cases.
  static const String dart = 'dart';

  /// Generation mode that creates only Dart key constants.
  ///
  /// This mode generates:
  /// - Dart key constants with static methods for easy_localization integration
  /// - No value maps are generated
  ///
  /// Value: `'dart-keys'`
  ///
  /// Use this mode when you only need the key constants and will handle
  /// value loading separately.
  static const String dartKeys = 'dart-keys';

  /// Generation mode that creates only Dart value maps.
  ///
  /// This mode generates:
  /// - Dart value maps for all supported languages
  /// - No key constants are generated
  ///
  /// Value: `'dart-values'`
  ///
  /// Use this mode when you already have key constants and only need
  /// to regenerate the value maps.
  static const String dartValues = 'dart-values';

  /// Generation mode that creates JSON value files.
  ///
  /// This mode generates:
  /// - JSON files containing flattened key-value pairs
  /// - One JSON file per language
  ///
  /// Value: `'json-values'`
  ///
  /// Use this mode when you need JSON output instead of Dart code,
  /// for example when integrating with other systems or frameworks.
  static const String jsonValues = 'json-values';

  /// A list containing all supported generation modes.
  ///
  /// This list includes all available generation modes and is used
  /// internally for mode validation and parsing.
  ///
  /// Contains: `[dart, dartKeys, dartValues, jsonValues]`
  ///
  /// Returns:
  /// A [List<String>] containing all valid generation mode values
  static const List<String> supportedGenerateModes = [
    dart,
    dartKeys,
    dartValues,
    jsonValues,
  ];
}
