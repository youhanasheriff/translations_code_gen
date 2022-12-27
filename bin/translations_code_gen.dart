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

  // Write the Dart code to a file
  final outputFile = File(outputFileName);
  await outputFile.writeAsString(dartCode);
}
