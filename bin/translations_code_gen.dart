import 'package:settings_yaml/settings_yaml.dart';
import 'package:translations_code_gen/translations_code_gen.dart' as code_gen;

import 'dart:convert';
import 'dart:io';

final configNotSpecifiedError = '''

------------------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------------------
''';

void main(List<String> arguments) async {
  String pathToConfiguration = 'translations_code_gen.yaml';

  stderr.writeln({
    'pathToConfiguration': pathToConfiguration,
  });

  if (!File('translations_code_gen.yaml').existsSync()) {
    stderr.writeln('''

------------------------------------------------------------------------------------------------------------
  -> Configuration file not found at translations_code_gen.yaml
  -> Using pubspec.yaml
------------------------------------------------------------------------------------------------------------
 ''');
    pathToConfiguration = 'pubspec.yaml';
  }

  if (arguments.isNotEmpty) {
    stderr.writeln('''

------------------------------------------------------------------------------------------------------------
  -> Passing arguments is not supported from translations_code_gen: 1.1.0.

  -> You must specify the input and output files for the keys and values generation.
  -> Specify in the pubspec.yaml file or create a translations_code_gen.yaml file to specify it.
------------------------------------------------------------------------------------------------------------
''');
    exit(1);
  }

  SettingsYaml coonfiguration =
      SettingsYaml.load(pathToSettings: pathToConfiguration);

  final configExist = coonfiguration.selectorExists('translations_code_gen');

  if (!configExist) {
    stderr.writeln(configNotSpecifiedError);
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
    stderr.writeln(configNotSpecifiedError);
    exit(1);
  }

  {
    final inputFileName = keysInput;
    final outputFileName = keysOutput;

    // Read the JSON file
    final file = File(inputFileName);
    final jsonString = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonString);

    // Generate the Dart code
    final dartCode = code_gen.generateDartCodeKeys(data);

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

    stderr.writeln('Generating $outputFileName...');

    // Write the Dart code to a file
    final outputFile = File(outputFileName);
    await outputFile.create(recursive: true);
    await outputFile.writeAsString(dartCode);

    stderr.writeln('done!!');
  }

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
        final dartCode = code_gen.generateDartCodeValues(data, lang);

        final outputDir = Directory(outputFileDir.contains('/')
            ? outputFileDir
                .split('/')
                .sublist(0, outputFileDir.split('/').length - 1)
                .join('/')
            : '.');

        if (!await outputDir.exists()) {
          await outputDir.create(recursive: true);
        }

        stderr.writeln('Generating ${outputDir.path}/$lang.dart...');

        // Write the Dart code to a file
        final outputFile = File('$outputFileDir/$lang.dart');
        await outputFile.create(recursive: true);
        await outputFile.writeAsString(dartCode);

        stderr.writeln('done!!');
      }
    }
  }
}
