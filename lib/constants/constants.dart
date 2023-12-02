/// Constants used in the project
/// Author: Youhana Sheriff
/// Generate Args: -g (or) --generate
class SupportedArguments {
  static const shortHandGenerate = '-g';
  static const longHandGenerate = '--generate';

  static const supportedArguments = [shortHandGenerate, longHandGenerate];
}

/// Constants used in the project
/// Author: Youhana Sheriff
/// Generate Modes: dart, dart-keys, dart-values, json-values
class SupportedGenerateModes {
  static const dart = 'dart';
  static const dartKeys = 'dart-keys';
  static const dartValues = 'dart-values';
  static const jsonValues = 'json-values';

  static const supportedGenerateModes = [
    dart,
    dartKeys,
    dartValues,
    jsonValues,
  ];
}
