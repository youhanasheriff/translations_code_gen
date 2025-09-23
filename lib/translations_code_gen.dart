/// A comprehensive library for generating Dart code from translation files.
///
/// This library provides functionality to generate Dart constants, value maps,
/// and JSON files from translation source files, making it easier to work with
/// internationalization in Flutter and Dart applications.
///
/// The library supports multiple generation modes and integrates seamlessly
/// with the `easy_localization` package for Flutter internationalization.
///
/// Key features:
/// - Generate Dart key constants with type-safe access
/// - Generate Dart value maps for runtime translation lookup
/// - Generate JSON value files for external consumption
/// - Support for nested translation structures
/// - Integration with easy_localization package
/// - Configurable input and output paths
///
/// Example usage:
/// ```dart
/// import 'package:translations_code_gen/translations_code_gen.dart';
///
/// // Generate both keys and values
/// await translationCodeGen(['--generate=dart']);
///
/// // Generate only key constants
/// await translationCodeGen(['-g=dart-keys']);
/// ```
///
/// See also:
/// * [SupportedArguments] for available command-line arguments
/// * [SupportedGenerateModes] for available generation modes
library translations_code_gen;

import 'package:settings_yaml/settings_yaml.dart';

import 'dart:convert';
import 'dart:io';

import 'constants/constants.dart';
import 'constants/errors.dart';
import 'generators/generators.dart';

/// Generates Dart code from translation files based on the provided arguments.
///
/// This function is the main entry point for the translations_code_gen tool.
/// It processes command-line arguments, reads configuration files, and generates
/// the appropriate Dart code based on the specified generation mode.
///
/// The function performs the following operations:
/// 1. Parses and validates command-line arguments
/// 2. Reads configuration from pubspec.yaml or translations_code_gen.yaml
/// 3. Validates the specified generation mode
/// 4. Generates the requested output files based on the mode
///
/// ## Supported Generation Modes
///
/// - `dart`: Generates both Dart key constants and value maps (default)
/// - `dart-keys`: Generates only Dart key constants with easy_localization integration
/// - `dart-values`: Generates only Dart value maps for runtime lookup
/// - `json-values`: Generates JSON files with flattened key-value pairs
///
/// ## Configuration
///
/// Configuration can be provided through either:
/// - `pubspec.yaml` file under the `translations_code_gen` section
/// - `translations_code_gen.yaml` file in the project root directory
///
/// Required configuration fields:
/// - `input_file_path`: Path to the source translation file
/// - `output_keys_file_path`: Path for generated Dart keys file
/// - `output_values_file_path`: Path for generated Dart values file
/// - `output_json_values_file_path`: Path for generated JSON values file
///
/// ## Example Usage
///
/// ```bash
/// # Command line usage
/// dart run translations_code_gen --generate=dart
/// dart run translations_code_gen -g=dart-keys
/// ```
///
/// ```dart
/// // Programmatic usage
/// await translationCodeGen(['--generate=dart']);
/// await translationCodeGen(['-g=dart-keys']);
/// ```
///
/// ## Error Handling
///
/// The function handles various error conditions:
/// - Invalid or missing command-line arguments
/// - Missing or invalid configuration files
/// - Unsupported generation modes
/// - File I/O errors during generation
///
/// Error messages are displayed to help users resolve configuration issues.
///
/// [arguments] A list of command-line arguments to process. Must contain
///             exactly one argument in the format `-g=mode` or `--generate=mode`
///             where `mode` is one of the supported generation modes.
///
/// Returns a [Future<void>] that completes when generation is finished successfully
///         or throws an error if generation fails.
///
/// Throws:
/// - Prints error messages and exits for invalid arguments or configuration
/// - May throw [FileSystemException] for file I/O errors
/// - May throw [FormatException] for invalid YAML configuration
///
/// See also:
/// * [SupportedArguments] for valid command-line argument formats
/// * [SupportedGenerateModes] for valid generation mode values
/// * [ConfigErrors] for configuration error messages
/// * [GenerateErrors] for generation mode error messages
/// * [ArgumentsErrors] for argument validation error messages
void translationCodeGen(List<String> arguments) async {
  String pathToConfiguration = 'translations_code_gen.yaml';
  String generateMode = SupportedGenerateModes.dart;

  if (!File(pathToConfiguration).existsSync()) {
    stderr.writeln();
    stderr.writeln(ConfigErrors.configNotFoundWarning);
    pathToConfiguration = 'pubspec.yaml';
  }

  if (arguments.isNotEmpty) {
    for (int i = 0; i < arguments.length; i++) {
      final arg = arguments[i];
      if (arg.contains(SupportedArguments.supportedArguments[0]) ||
          arg.contains(SupportedArguments.supportedArguments[1])) {
        final mode = arg.contains('=') ? arg.split('=').last : arguments[i + 1];
        if (SupportedGenerateModes.supportedGenerateModes.contains(mode)) {
          generateMode = mode;
        } else {
          stderr.writeln(GenerateErrors.invalidGenerateModeError);
          exit(1);
        }
      }
    }
  }

  if (arguments.length > 1) {
    stderr.writeln(ArgumentsErrors.moreThanOneArgumentError);
    exit(1);
  }

  SettingsYaml configuration = SettingsYaml.load(
    pathToSettings: pathToConfiguration,
  );

  final configExist = configuration.selectorExists('translations_code_gen');

  if (!configExist) {
    stderr.writeln(ConfigErrors.configNotSpecifiedError);
    exit(1);
  }

  String? keysInput = configuration.selectAsMap(
    'translations_code_gen',
  )?['keys']?['input'];
  String? keysOutput = configuration.selectAsMap(
    'translations_code_gen',
  )?['keys']?['output'];
  String? valuesInput = configuration.selectAsMap(
    'translations_code_gen',
  )?['values']?['input'];
  String? valuesOutput = configuration.selectAsMap(
    'translations_code_gen',
  )?['values']?['output'];

  if (keysInput == null ||
      keysOutput == null ||
      valuesInput == null ||
      valuesOutput == null) {
    stderr.writeln(ConfigErrors.configNotSpecifiedError);
    exit(1);
  }

  if (generateMode == SupportedGenerateModes.dart ||
      generateMode == SupportedGenerateModes.dartKeys) {
    await _generateDartKeys(keysInput: keysInput, keysOutput: keysOutput);
  }

  if (generateMode == SupportedGenerateModes.dart ||
      generateMode == SupportedGenerateModes.dartValues) {
    await _generateDartValues(
      valuesInput: valuesInput,
      valuesOutput: valuesOutput,
      generateMode: generateMode,
    );
  }

  if (generateMode == SupportedGenerateModes.jsonValues) {
    await _generateJsonValues(
      valuesInput: valuesInput,
      valuesOutput: valuesOutput,
    );
  }
}

Future<void> _generateDartKeys({
  required String keysInput,
  required String keysOutput,
}) async {
  final inputFileName = keysInput;
  final outputFileName = keysOutput;

  // Read the JSON file
  final file = File(inputFileName);
  final jsonString = await file.readAsString();
  final Map<String, dynamic> data = jsonDecode(jsonString);

  // Generate the Dart code
  final dartCode = generateDartCodeKeys(data);

  // Create the output directory if it does not exist
  final outputDir = Directory(
    outputFileName.contains('/')
        ? outputFileName
            .split('/')
            .sublist(0, outputFileName.split('/').length - 1)
            .join('/')
        : '.',
  );

  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  stderr.writeln();
  stderr.writeln('GENERATING DART KEYS');
  stderr.writeln('  -> Generating $outputFileName...');

  // Write the Dart code to a file
  final outputFile = File(outputFileName);
  await outputFile.create(recursive: true);
  await outputFile.writeAsString(dartCode);

  stderr.writeln('DONE!!');
  stderr.writeln();
}

Future<void> _generateDartValues({
  required String valuesInput,
  required String valuesOutput,
  required String generateMode,
}) async {
  {
    final inputFileDir = valuesInput[valuesInput.length - 1] == '/'
        ? valuesInput.substring(0, valuesInput.length - 1)
        : '$valuesInput/';
    final outputFileDir = valuesOutput[valuesOutput.length - 1] == '/'
        ? valuesOutput.substring(0, valuesOutput.length - 1)
        : '$valuesOutput/';

    // Get a Directory object for the specified path
    Directory dir = Directory(inputFileDir);

    // Check if the directory exists
    if (dir.existsSync()) {
      // List the contents of the directory
      List<FileSystemEntity> contents = dir.listSync();

      stderr.writeln('GENERATING DART VALUES');
      // Print the names of the files and directories in the directory
      for (FileSystemEntity entity in contents) {
        // Create the output directory if it does not exist
        // Read the JSON file
        final file = File(entity.path);
        final jsonString = await file.readAsString();
        final Map<String, dynamic> data = jsonDecode(jsonString);

        final lang = entity.path.contains('/')
            ? entity.path.split('/').last.split('.').first
            : entity.path.split('.').first;

        // Generate the Dart code
        final dartCode = generateDartCodeValues(
          data,
          lang,
          generateMode: generateMode,
        );

        final outputDir = Directory(
          outputFileDir.contains('/')
              ? outputFileDir
                  .split('/')
                  .sublist(0, outputFileDir.split('/').length - 1)
                  .join('/')
              : '.',
        );

        if (!await outputDir.exists()) {
          await outputDir.create(recursive: true);
        }

        stderr.writeln('  -> Generating ${outputDir.path}/$lang.dart...');

        // Write the Dart code to a file
        final outputFile = File('$outputFileDir/$lang.dart');
        await outputFile.create(recursive: true);
        await outputFile.writeAsString(dartCode);
      }
      stderr.writeln('DONE!!');
      stderr.writeln();
    }
  }
}

Future<void> _generateJsonValues({
  required String valuesInput,
  required String valuesOutput,
}) async {
  {
    final inputFileDir = valuesInput[valuesInput.length - 1] == '/'
        ? valuesInput.substring(0, valuesInput.length - 1)
        : '$valuesInput/';
    final outputFileDir = valuesOutput[valuesOutput.length - 1] == '/'
        ? valuesOutput.substring(0, valuesOutput.length - 1)
        : '$valuesOutput/';

    // Get a Directory object for the specified path
    Directory dir = Directory(inputFileDir);

    // Check if the directory exists
    if (dir.existsSync()) {
      // List the contents of the directory
      List<FileSystemEntity> contents = dir.listSync();

      stderr.writeln('GENERATING JSON VALUES');
      // Print the names of the files and directories in the directory
      for (FileSystemEntity entity in contents) {
        // Create the output directory if it does not exist
        // Read the JSON file
        final file = File(entity.path);
        final jsonString = await file.readAsString();
        final Map<String, dynamic> data = jsonDecode(jsonString);

        final lang = entity.path.contains('/')
            ? entity.path.split('/').last.split('.').first
            : entity.path.split('.').first;

        // Generate the Dart code
        final jsonStringValue = generateJsonValues(data);

        final outputDir = Directory(
          outputFileDir.contains('/')
              ? outputFileDir
                  .split('/')
                  .sublist(0, outputFileDir.split('/').length - 1)
                  .join('/')
              : '.',
        );

        if (!await outputDir.exists()) {
          await outputDir.create(recursive: true);
        }

        stderr.writeln('  -> Generating ${outputDir.path}/$lang.json...');

        // Write the Dart code to a file
        final outputFile = File('$outputFileDir/$lang.json');
        await outputFile.create(recursive: true);
        await outputFile.writeAsString(jsonStringValue);
      }
      stderr.writeln('DONE!!');
      stderr.writeln();
    }
  }
}
