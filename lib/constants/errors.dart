class ConfigErrors {
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
  -> For more information vist: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';

  static final configNotFoundWarning = '''
------------------------------------------------------------------------------------------------------------
  -> Configuration file not found at translations_code_gen.yaml
  -> Using pubspec.yaml
------------------------------------------------------------------------------------------------------------
 ''';
}

class GenerateErrors {
  static final invalidGenerateModeError = '''
------------------------------------------------------------------------------------------------------------
  -> Invalid generate mode.
  -> Supported generate modes are: dart, dart-keys, dart-only, json-values

  -> For more information vist: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';
}

class ArgumentsErrors {
  static final moreThanOneArgumentError = '''
------------------------------------------------------------------------------------------------------------
  -> Passing arguments other then -g (or) --generate is not supported from translations_code_gen: 1.1.2.

  -> Expample:
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
  -> For more information vist: https://pub.dev/packages/translations_code_gen
  -> or visit: https://github.com/youhanasheriff/translations_code_gen
------------------------------------------------------------------------------------------------------------
''';
}
