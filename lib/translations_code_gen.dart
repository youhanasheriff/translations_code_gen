import 'package:settings_yaml/settings_yaml.dart';

import 'dart:convert';
import 'dart:io';

import 'constants/constants.dart';
import 'constants/errors.dart';
import 'generators/generators.dart';

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

  SettingsYaml coonfiguration =
      SettingsYaml.load(pathToSettings: pathToConfiguration);

  final configExist = coonfiguration.selectorExists('translations_code_gen');

  if (!configExist) {
    stderr.writeln(ConfigErrors.configNotSpecifiedError);
    exit(1);
  }

  String? keysInput =
      coonfiguration.selectAsMap('translations_code_gen')?['keys']?['input'];
  String? keysOutput =
      coonfiguration.selectAsMap('translations_code_gen')?['keys']?['output'];
  String? valuesInput =
      coonfiguration.selectAsMap('translations_code_gen')?['values']?['input'];
  String? valuesOutput =
      coonfiguration.selectAsMap('translations_code_gen')?['values']?['output'];

  if (keysInput == null ||
      keysOutput == null ||
      valuesInput == null ||
      valuesOutput == null) {
    stderr.writeln(ConfigErrors.configNotSpecifiedError);
    exit(1);
  }

  if (generateMode == SupportedGenerateModes.dart ||
      generateMode == SupportedGenerateModes.dartKeys) {
    await _generateDartKeys(
      keysInput: keysInput,
      keysOutput: keysOutput,
    );
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
  final outputDir = Directory(outputFileName.contains('/')
      ? outputFileName
          .split('/')
          .sublist(0, outputFileName.split('/').length - 1)
          .join('/')
      : '.');

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

        final outputDir = Directory(outputFileDir.contains('/')
            ? outputFileDir
                .split('/')
                .sublist(0, outputFileDir.split('/').length - 1)
                .join('/')
            : '.');

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
        final jsonStringValue = generateJsonValues(data, lang);

        final outputDir = Directory(outputFileDir.contains('/')
            ? outputFileDir
                .split('/')
                .sublist(0, outputFileDir.split('/').length - 1)
                .join('/')
            : '.');

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
