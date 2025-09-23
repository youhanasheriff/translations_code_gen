/// A collection of help messages and documentation for the translations code generator.
///
/// This class provides comprehensive help content that is displayed to users
/// when they request help or when they need guidance on using the tool correctly.
///
/// The help content includes detailed information about:
/// - Supported command-line arguments and their usage
/// - Available generation modes and their purposes
/// - Configuration requirements and examples
/// - Links to additional documentation and resources
///
/// Example usage:
/// ```dart
/// print(HelpPrints.commandsHelp);
/// ```
///
/// See also:
/// * [SupportedArguments] for the available command-line arguments
/// * [SupportedGenerateModes] for the available generation modes
/// * [ConfigErrors] for configuration related error messages
class HelpPrints {
  /// Comprehensive help message containing all usage information for the tool.
  ///
  /// This help message provides users with complete documentation about:
  /// - How to use the translations_code_gen command
  /// - Supported command-line arguments (`-g` and `--generate`)
  /// - Available generation modes (dart, dart-keys, dart-values, json-values)
  /// - Configuration file requirements (pubspec.yaml or translations_code_gen.yaml)
  /// - Links to online documentation and GitHub repository
  ///
  /// The help content is formatted as a table showing:
  /// - Command syntax and examples
  /// - Each generation mode with its description
  /// - Configuration requirements and setup instructions
  ///
  /// This message is typically displayed when:
  /// - Users run the tool with invalid arguments
  /// - Users request help explicitly
  /// - The tool encounters configuration issues
  ///
  /// Returns:
  /// A [String] containing the formatted help documentation
  static final String commandsHelp = '''
------------------------------------------------------------------------------------------------------------
  -> Commands:

  ->|--------------------|-------------|----------------------------------------|
    | Command            | Value       | Description                            |
    |--------------------|-------------|----------------------------------------|
    | -g (or) --generate | dart        | Generate dart code for keys and values.|
    |                    | dart-keys   | Generate dart code for keys only.      |
    |                    | dart-values | Generate dart code for values only.    |
    |                    | json-values | Generate dart code for values only.    |
    |--------------------|-------------|----------------------------------------|

  -> For more information visit: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';
}
