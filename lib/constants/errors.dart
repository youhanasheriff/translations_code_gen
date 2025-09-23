/// A collection of configuration-related error messages and warnings.
/// 
/// This class provides standardized error messages and warnings that are
/// displayed when configuration file issues are encountered during the
/// translations code generation process.
/// 
/// These messages help users understand and resolve configuration problems
/// such as missing or unspecified configuration files.
/// 
/// Example usage:
/// ```dart
/// if (configFile == null) {
///   print(ConfigErrors.configNotSpecifiedError);
/// }
/// ```
/// 
/// See also:
/// * [GenerateErrors] for generation mode related errors
/// * [ArgumentsErrors] for command-line argument related errors
class ConfigErrors {
  /// Error message displayed when no configuration is specified.
  /// 
  /// This error occurs when the user runs the tool without providing
  /// the required configuration in pubspec.yaml or translations_code_gen.yaml.
  /// 
  /// The message guides users to specify input and output files for
  /// keys and values generation in their configuration file.
  /// 
  /// Returns:
  /// A [String] containing the detailed error message with examples
  static final configNotSpecifiedError = '''
------------------------------------------------------------------------------------------------------------
  -> Configuration not specified.
  -> You must specify the input and output files for the keys and values generation.
  -> Specify in the pubspec.yaml file or create a translations_code_gen.yaml file to specify it.

  -> Example:
    translations_code_gen:
      keys:
        input: 'assets/translations/en.json'
        output: 'lib/translations/keys.dart'
      values:
        input: 'assets/translations/'
        output: 'lib/translations/values/'

  -> Please check your pubspec.yaml or translations_code_gen.yaml file.
  -> For more information visit: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';

  /// Warning message displayed when translations_code_gen.yaml is not found.
  /// 
  /// This warning occurs when the tool looks for a dedicated configuration
  /// file but doesn't find it, so it falls back to using pubspec.yaml.
  /// 
  /// The message informs users that pubspec.yaml will be used instead
  /// of the missing dedicated configuration file.
  /// 
  /// Returns:
  /// A [String] containing the warning message about fallback configuration
  static final configNotFoundWarning = '''
------------------------------------------------------------------------------------------------------------
  -> Configuration file not found at translations_code_gen.yaml
  -> Using pubspec.yaml
------------------------------------------------------------------------------------------------------------
''';
}

/// A collection of generation mode related error messages.
/// 
/// This class provides standardized error messages that are displayed
/// when invalid or unsupported generation modes are specified during
/// the translations code generation process.
/// 
/// These messages help users understand which generation modes are
/// supported and guide them to use valid options.
/// 
/// Example usage:
/// ```dart
/// if (!isValidGenerateMode(mode)) {
///   print(GenerateErrors.invalidGenerateModeError);
/// }
/// ```
/// 
/// See also:
/// * [ConfigErrors] for configuration related errors
/// * [ArgumentsErrors] for command-line argument related errors
class GenerateErrors {
  /// Error message displayed when an invalid generation mode is specified.
  /// 
  /// This error occurs when the user provides a generation mode that is
  /// not supported by the tool. The message lists all valid generation
  /// modes that can be used.
  /// 
  /// Valid generation modes include:
  /// - `dart`: Generate both keys and values
  /// - `dart-keys`: Generate only key constants
  /// - `dart-only`: Generate dart code only
  /// - `json-values`: Generate JSON value files
  /// 
  /// Returns:
  /// A [String] containing the detailed error message with supported modes
  static final invalidGenerateModeError = '''
------------------------------------------------------------------------------------------------------------
  -> Invalid generate mode.
  -> Supported generate modes are: dart, dart-keys, dart-only, json-values

  -> For more information visit: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';
}

/// A collection of command-line argument related error messages.
/// 
/// This class provides standardized error messages that are displayed
/// when issues with command-line arguments are encountered during the
/// translations code generation process.
/// 
/// These messages help users understand and resolve problems with
/// command-line argument parsing and validation.
/// 
/// Example usage:
/// ```dart
/// if (hasInvalidArguments) {
///   print(ArgumentsErrors.moreThanOneArgumentError);
/// }
/// ```
/// 
/// See also:
/// * [ConfigErrors] for configuration related errors
/// * [GenerateErrors] for generation mode related errors
class ArgumentsErrors {
  /// Error message displayed when more than one argument is passed or unsupported arguments are used.
  /// 
  /// This error occurs when the user provides multiple command-line arguments
  /// or uses arguments other than the supported `-g` or `--generate` options.
  /// 
  /// The message provides:
  /// - Information about supported arguments since version 1.3.2
  /// - Usage examples with correct syntax
  /// - A table of all supported commands and their descriptions
  /// - Links to documentation for more information
  /// 
  /// Supported arguments:
  /// - `-g` or `--generate`: Specify the generation mode
  /// 
  /// Valid generation modes:
  /// - `dart`: Generate both keys and values
  /// - `dart-keys`: Generate only key constants
  /// - `dart-values`: Generate only value maps
  /// - `json-values`: Generate JSON value files
  /// 
  /// Returns:
  /// A [String] containing the detailed error message with usage examples
  static final String moreThanOneArgumentError = '''
------------------------------------------------------------------------------------------------------------
  -> Passing arguments other then -g (or) --generate is not supported from translations_code_gen: 1.3.2.

  -> Example:
    translations_code_gen -g=json-values
    translations_code_gen --generate=json-values

  ->|--------------------|-------------|----------------------------------------|
    | Command            | Value       | Description                            |
    |--------------------|-------------|----------------------------------------|
    | -g (or) --generate | dart        | Generate dart code for keys and values.|
    |                    | dart-keys   | Generate dart code for keys only.      |
    |                    | dart-values | Generate dart code for values only.    |
    |                    | json-values | Generate dart code for values only.    |
    |--------------------|-------------|----------------------------------------|

  -> You must specify the input and output files for the keys and values generation.
  -> Specify in the pubspec.yaml file or create a translations_code_gen.yaml file to specify it.
  -> For more information visit: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';
}
