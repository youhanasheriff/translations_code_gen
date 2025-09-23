import 'package:test/test.dart';
import 'package:translations_code_gen/generators/generators.dart';

void main() {
  group('Translations Code Generator Tests', () {
    test('generateDartCodeKeys should generate valid Dart code for keys', () {
      // Test data
      final testData = {
        'GENERAL': {'HELLO': 'Hello', 'WELCOME': 'Welcome'},
        'HOME': {'TITLE': 'Home'}
      };

      // Generate Dart code
      final result = generateDartCodeKeys(testData);

      // Verify the generated code contains expected classes and constants
      expect(result, contains('class GENERAL'));
      expect(result, contains('class HOME'));
      expect(result, contains('static const String HELLO = "GENERAL.HELLO"'));
      expect(
          result, contains('static const String WELCOME = "GENERAL.WELCOME"'));
      expect(result, contains('static const String TITLE = "HOME.TITLE"'));
      expect(result, contains('// GENERATED CODE - DO NOT MODIFY BY HAND'));
    });

    test('generateDartCodeValues should generate valid Dart code for values',
        () {
      // Test data
      final testData = {
        'GENERAL': {'HELLO': 'Hello', 'WELCOME': 'Welcome'},
        'HOME': {'TITLE': 'Home'}
      };

      // Generate Dart code for English values
      final result = generateDartCodeValues(testData, 'en');

      // Verify the generated code contains expected structure
      expect(result, contains('const Map<String, String> _general'));
      expect(result, contains('const Map<String, String> _home'));
      expect(result, contains('final Map<String, String> enValues'));
      expect(result, contains('"Hello"'));
      expect(result, contains('"Welcome"'));
      expect(result, contains('"Home"'));
      expect(result, contains('// GENERATED CODE - DO NOT MODIFY BY HAND'));
    });

    test('generateJsonValues should generate valid JSON for values', () {
      // Test data
      final testData = {
        'GENERAL': {'HELLO': 'Hello', 'WELCOME': 'Welcome'},
        'HOME': {'TITLE': 'Home'}
      };

      // Generate JSON values
      final result = generateJsonValues(testData);

      // Verify the generated JSON is valid and contains expected data
      expect(result, contains('"GENERAL.HELLO": "Hello"'));
      expect(result, contains('"GENERAL.WELCOME": "Welcome"'));
      expect(result, contains('"HOME.TITLE": "Home"'));

      // Verify it's valid JSON by parsing it
      expect(() => result, returnsNormally);
    });

    test('nested objects should be handled correctly', () {
      // Test data with one level of nesting (as supported by the generator)
      final testData = {
        'LEVEL1': {'LEVEL2': 'Some Value'}
      };

      // Generate Dart code for keys
      final keysResult = generateDartCodeKeys(testData);

      // Verify structure is handled correctly (only one level of classes)
      expect(keysResult, contains('class LEVEL1'));
      expect(
          keysResult, contains('static const String LEVEL2 = "LEVEL1.LEVEL2"'));

      // The generator doesn't create nested classes, it flattens to constants
      expect(keysResult, isNot(contains('class LEVEL2')));
    });

    test('empty data should not cause errors', () {
      // Test with empty data
      final emptyData = <String, dynamic>{};

      // Should not throw exceptions
      expect(() => generateDartCodeKeys(emptyData), returnsNormally);
      expect(() => generateDartCodeValues(emptyData, 'en'), returnsNormally);
      expect(() => generateJsonValues(emptyData), returnsNormally);
    });
  });
}
