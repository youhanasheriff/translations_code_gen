import 'package:translations_code_gen/translations_code_gen.dart' as code_gen;
import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.length != 3) {
    stderr.writeln(
        'Usage: codegen [type (keys or values)] input.json output.dart');
    exit(1);
  }

  final type = arguments[0];

  if (type == 'keys') {
    final inputFileName = arguments[1];
    final outputFileName = arguments[2];

    final lang = outputFileName.contains('/')
        ? outputFileName.split('/').last.split('.').first
        : outputFileName.split('.').first;

    // Read the JSON file
    final file = File(inputFileName);
    final jsonString = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonString);

    // Generate the Dart code
    final dartCode = code_gen.generateDartCode(data, type, lang);

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

    stderr.write('Generating $outputFileName...');

    // Write the Dart code to a file
    final outputFile = File(outputFileName);
    await outputFile.writeAsString(dartCode);

    stderr.writeln('done!!');
  } else if (type == 'values') {
    final inputFileDir = arguments[1][arguments[1].length - 1] == '/'
        ? arguments[1].substring(0, arguments[1].length - 1)
        : '${arguments[1]}/';
    final outputFileDir = arguments[2][arguments[2].length - 1] == '/'
        ? arguments[2].substring(0, arguments[2].length - 1)
        : '${arguments[2]}/';

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
        final dartCode = code_gen.generateDartCode(data, type, lang);

        final outputDir = Directory(outputFileDir.contains('/')
            ? outputFileDir
                .split('/')
                .sublist(0, outputFileDir.split('/').length - 1)
                .join('/')
            : '.');

        if (!await outputDir.exists()) {
          await outputDir.create(recursive: true);
        }

        stderr.write('Generating ${outputDir.path}/$lang.dart...');

        // Write the Dart code to a file
        final outputFile = File('$outputFileDir/$lang.dart');
        await outputFile.writeAsString(dartCode);

        stderr.writeln('done!!');
      }
    } else {
      throw Exception('Directory does not exist:  $inputFileDir');
    }
  } else {
    throw Exception('Unknown type: $type');
  }
}
