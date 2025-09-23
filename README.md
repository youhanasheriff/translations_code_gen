# Translations code generator

<p align="center">
  <a href="https://pub.dev/packages/translations_code_gen">
    <img src="https://img.shields.io/pub/v/translations_code_gen?translations_code_gen=pub.dev&labelColor=333940&logo=dart">
  </a>
  <a href="https://t.me/youhanasheriff">
    <img src="https://img.shields.io/static/v1?label=join&message=Hey dev!&labelColor=333940&logo=telegram&logoColor=white&color=229ED9">
  </a>
  <a href="https://x.com/youhanasheriff">
    <img src="https://img.shields.io/x/follow/youhanasheriff?style=flat&label=Follow&color=1DA1F2&labelColor=333940&logo=x&logoColor=fff">
  </a>
</p>

<p align="center">
This is a simple tool to generate the translations code for the Dart/Flutter projects.
</p>

<p align="center">
  <a href="https://youhanasheriff.com">Quickstart</a> •
  <a href="https://pub.dev/packages/translations_code_gen">Pub.dev</a>
</p>

## Install

### 1. Add the dependency

```yaml
dependencies:
  translations_code_gen: ^1.3.4
```

### 2. Run this commend

```bash
flutter pub get
```

## Usage

### 1. Create a translations files in `assets` folder

Create a folder called `assets` in the root of your project and create a file called `en.json` and `ar.json` and add the following content:

example: `assets/translations/en.json`

```json
{
  "GENERAL": {
    "HELLO": "Hello",
    "WELCOME": "Welcome",
    "WELCOME_USER": "Welcome {name}!",
    "GREETING_WITH_TIME": "Good {timeOfDay}, {name}!"
  },
  "HOME": {
    "TITLE": "Home"
  },
  "MESSAGES": {
    "SIMPLE_MESSAGE": "This is a simple message",
    "USER_PROFILE": "User {username} has {count} notifications",
    "POSITIONAL_EXAMPLE": "First: {}, Second: {}, Third: {}",
    "MIXED_PLACEHOLDERS": "Hello {name}, you have {} new messages and {} pending tasks"
  }
}
```

example: `assets/translations/ar.json`

```json
{
  "GENERAL": {
    "HELLO": "مرحبا",
    "WELCOME": "أهلا بك",
    "WELCOME_USER": "أهلا بك {name}!",
    "GREETING_WITH_TIME": "{timeOfDay} طيب، {name}!"
  },
  "HOME": {
    "TITLE": "الرئيسية"
  },
  "MESSAGES": {
    "SIMPLE_MESSAGE": "هذه رسالة بسيطة",
    "USER_PROFILE": "المستخدم {username} لديه {count} إشعارات",
    "POSITIONAL_EXAMPLE": "الأول: {}، الثاني: {}، الثالث: {}",
    "MIXED_PLACEHOLDERS": "مرحبا {name}، لديك {} رسائل جديدة و {} مهام معلقة"
  }
}
```

### 2. Add the translations file paths to the `pubspec.yaml` or `translations_code_gen.yaml` file

```yaml
translations_code_gen:
  keys:
    input: 'assets/translations/en.json'
    output: 'lib/translations/keys.dart'
  values:
    input: 'assets/translations/'
    output: 'lib/translations/values/'
```

Run this command to generate the translations `keys` and `values` to the `output`:

```bash
flutter pub run translations_code_gen
```

The `-g` or `--generate` flag is optional, if you don't use it, the tool will normally generate dart keys and values code for you.

This will generate the following keys to the `lib/translations/keys.dart` file:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:easy_localization/easy_localization.dart';

class GENERAL {
  static const String _HELLO = "GENERAL.HELLO";
  static String hello() => _HELLO.tr();
  static const String _WELCOME = "GENERAL.WELCOME";
  static String welcome() => _WELCOME.tr();
  static const String _WELCOME_USER = "GENERAL.WELCOME_USER";
  static String welcomeUser({String? name, }) => _WELCOME_USER.tr(namedArgs: {if (name != null) 'name': name, });
  static const String _GREETING_WITH_TIME = "GENERAL.GREETING_WITH_TIME";
  static String greetingWithTime({String? timeOfDay, String? name, }) => _GREETING_WITH_TIME.tr(namedArgs: {if (timeOfDay != null) 'timeOfDay': timeOfDay, if (name != null) 'name': name, });
}

class HOME {
  static const String _TITLE = "HOME.TITLE";
  static String title() => _TITLE.tr();
}

class MESSAGES {
  static const String _SIMPLE_MESSAGE = "MESSAGES.SIMPLE_MESSAGE";
  static String simpleMessage() => _SIMPLE_MESSAGE.tr();
  static const String _USER_PROFILE = "MESSAGES.USER_PROFILE";
  static String userProfile({String? username, String? count, }) => _USER_PROFILE.tr(namedArgs: {if (username != null) 'username': username, if (count != null) 'count': count, });
  static const String _POSITIONAL_EXAMPLE = "MESSAGES.POSITIONAL_EXAMPLE";
  static String positionalExample({List<String?>? args, }) => _POSITIONAL_EXAMPLE.tr(args: args?.whereType<String>().toList(), );
  static const String _MIXED_PLACEHOLDERS = "MESSAGES.MIXED_PLACEHOLDERS";
  static String mixedPlaceholders({String? name, List<String?>? args, }) => _MIXED_PLACEHOLDERS.tr(args: args?.whereType<String>().toList(), namedArgs: {if (name != null) 'name': name, });
}
```

and the following values to the `en.dart` and `ar.dart` file to `lib/translations/values/`

example: `lib/translations/values/en.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names

import '../keys.dart'; // sometimes you need to change this path to match your project structure

const Map<String, String> _general  = {
  GENERAL._HELLO: "Hello",
  GENERAL._WELCOME: "Welcome",
  GENERAL._WELCOME_USER: "Welcome {name}!",
  GENERAL._GREETING_WITH_TIME: "Good {timeOfDay}, {name}!",
};

const Map<String, String> _home  = {
  HOME._TITLE: "Home",
};

const Map<String, String> _messages  = {
  MESSAGES._SIMPLE_MESSAGE: "This is a simple message",
  MESSAGES._USER_PROFILE: "User {username} has {count} notifications",
  MESSAGES._POSITIONAL_EXAMPLE: "First: {}, Second: {}, Third: {}",
  MESSAGES._MIXED_PLACEHOLDERS: "Hello {name}, you have {} new messages and {} pending tasks",
};

final Map<String, String> enValues = {
  ..._general,
  ..._home,
  ..._messages,
};
```

example: `lib/translations/values/ar.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names

import '../keys.dart'; // sometimes you need to change this path to match your project structure

const Map<String, String> _general  = {
  GENERAL._HELLO: "مرحبا",
  GENERAL._WELCOME: "أهلا بك",
  GENERAL._WELCOME_USER: "أهلا بك {name}!",
  GENERAL._GREETING_WITH_TIME: "{timeOfDay} طيب، {name}!",
};

const Map<String, String> _home  = {
  HOME._TITLE: "الرئيسية",
};

const Map<String, String> _messages  = {
  MESSAGES._SIMPLE_MESSAGE: "هذه رسالة بسيطة",
  MESSAGES._USER_PROFILE: "المستخدم {username} لديه {count} إشعارات",
  MESSAGES._POSITIONAL_EXAMPLE: "الأول: {}، الثاني: {}، الثالث: {}",
  MESSAGES._MIXED_PLACEHOLDERS: "مرحبا {name}، لديك {} رسائل جديدة و {} مهام معلقة",
};

final Map<String, String> arValues = {
  ..._general,
  ..._home,
  ..._messages,
};
```

You might have to change the keys import path to match your project structure.

## Placeholder Types and Usage

This package supports three types of placeholders in your translation strings:

### 1. Named Placeholders `{name}`

Named placeholders use curly braces with a parameter name inside. They generate methods with named parameters.

**Translation JSON:**
```json
{
  "WELCOME_USER": "Welcome {name}!",
  "USER_STATS": "User {username} has {count} points"
}
```

**Generated Dart Code:**
```dart
static String welcomeUser({String? name, }) => _WELCOME_USER.tr(namedArgs: {if (name != null) 'name': name, });
static String userStats({String? username, String? count, }) => _USER_STATS.tr(namedArgs: {if (username != null) 'username': username, if (count != null) 'count': count, });
```

**Usage:**
```dart
Text(GENERAL.welcomeUser(name: 'John'))
Text(GENERAL.userStats(username: 'Alice', count: '150'))
```

### 2. Positional Placeholders `{}`

Positional placeholders use empty curly braces `{}`. They generate methods that accept a list of arguments.

**Translation JSON:**
```json
{
  "ORDERED_LIST": "First: {}, Second: {}, Third: {}"
}
```

**Generated Dart Code:**
```dart
static String orderedList({List<String?>? args, }) => _ORDERED_LIST.tr(args: args?.whereType<String>().toList(), );
```

**Usage:**
```dart
Text(MESSAGES.orderedList(args: ['Apple', 'Banana', 'Cherry']))
```

### 3. Mixed Placeholders `{name}` + `{}`

You can combine both named and positional placeholders in the same translation string.

**Translation JSON:**
```json
{
  "MIXED_MESSAGE": "Hello {name}, you have {} new messages and {} pending tasks"
}
```

**Generated Dart Code:**
```dart
static String mixedMessage({String? name, List<String?>? args, }) => _MIXED_MESSAGE.tr(args: args?.whereType<String>().toList(), namedArgs: {if (name != null) 'name': name, });
```

**Usage:**
```dart
Text(MESSAGES.mixedMessage(
  name: 'Alice',
  args: ['5', '3']
))
```

### 4. Simple Strings (No Placeholders)

Strings without placeholders generate simple methods that call `.tr()` directly.

**Translation JSON:**
```json
{
  "SIMPLE_MESSAGE": "This is a simple message"
}
```

**Generated Dart Code:**
```dart
static String simpleMessage() => _SIMPLE_MESSAGE.tr();
```

**Usage:**
```dart
Text(MESSAGES.simpleMessage())
```

### Key Features

- **Type Safety**: All generated methods provide compile-time type checking
- **Null Safety**: All parameters are nullable with proper null checks
- **easy_localization Integration**: Generated code works seamlessly with the `easy_localization` package
- **Automatic Formatting**: Translation keys are converted to camelCase method names
- **Private Constants**: Internal constants are prefixed with `_` to keep the API clean

### 4. Use the generated code

```dart
import 'package:flutter/material.dart';

import './translations/keys.dart';

// any translation package

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HOME.title()),
      ),
      body: Column(
        children: [
          // Simple translation without placeholders
          Text(GENERAL.hello()),
          
          // Named placeholder example
          Text(GENERAL.welcomeUser(name: 'John')),
          
          // Multiple named placeholders
          Text(GENERAL.greetingWithTime(
            timeOfDay: 'morning', 
            name: 'Sarah'
          )),
          
          // Positional placeholders
          Text(MESSAGES.positionalExample(
            args: ['Apple', 'Banana', 'Cherry']
          )),
          
          // Mixed placeholders (named + positional)
          Text(MESSAGES.mixedPlaceholders(
            name: 'Alice',
            args: ['5', '3']
          )),
          
          // User profile with named placeholders
          Text(MESSAGES.userProfile(
            username: 'developer',
            count: '12'
          )),
        ],
      ),
    );
  }
}
```

### 5. Same as above but with the `--generate` flag

```bash
flutter pub run translations_code_gen --generate=json-values
```

There are 4 types of code generation mode:

- `dart` (default): generate dart keys and values code
- `dart-keys`: generate dart keys only.
- `dart-values`: generate dart values only.
- `json-values`: generate json values only.

## Output with the `--generate=json-values` flag

example: `lib/translations/values/en.json`

```json
{
  "GENERAL.HELLO": "Hello",
  "GENERAL.WELCOME": "Welcome",
  "GENERAL.WELCOME_USER": "Welcome {name}!",
  "GENERAL.GREETING_WITH_TIME": "Good {timeOfDay}, {name}!",
  "HOME.TITLE": "Home",
  "MESSAGES.SIMPLE_MESSAGE": "This is a simple message",
  "MESSAGES.USER_PROFILE": "User {username} has {count} notifications",
  "MESSAGES.POSITIONAL_EXAMPLE": "First: {}, Second: {}, Third: {}",
  "MESSAGES.MIXED_PLACEHOLDERS": "Hello {name}, you have {} new messages and {} pending tasks"
}
```

example: `lib/translations/values/ar.json`

```json
{
  "GENERAL.HELLO": "مرحبا",
  "GENERAL.WELCOME": "أهلا بك",
  "GENERAL.WELCOME_USER": "أهلا بك {name}!",
  "GENERAL.GREETING_WITH_TIME": "{timeOfDay} طيب، {name}!",
  "HOME.TITLE": "الرئيسية",
  "MESSAGES.SIMPLE_MESSAGE": "هذه رسالة بسيطة",
  "MESSAGES.USER_PROFILE": "المستخدم {username} لديه {count} إشعارات",
  "MESSAGES.POSITIONAL_EXAMPLE": "الأول: {}، الثاني: {}، الثالث: {}",
  "MESSAGES.MIXED_PLACEHOLDERS": "مرحبا {name}، لديك {} رسائل جديدة و {} مهام معلقة"
}
```

## Development

### Requirements

- **Dart SDK**: `>=3.1.0 <4.0.0` (recommended: `3.9.2` or later)
- **Flutter SDK**: `3.35.4` or later (when using FVM)

### Setting up with FVM (Flutter Version Manager)

This project uses [FVM](https://fvm.app/) for Flutter and Dart SDK version management to ensure consistent development environments.

#### 1. Install FVM

```bash
# Using Homebrew (macOS)
brew tap leoafarias/fvm
brew install fvm

# Using pub global
dart pub global activate fvm

# Using Chocolatey (Windows)
choco install fvm
```

#### 2. Install and use the project's Flutter version

```bash
# Install the required Flutter version
fvm install 3.35.4

# Use it for this project
fvm use 3.35.4
```

#### 3. Run commands with FVM

```bash
# Get dependencies
fvm dart pub get

# Run the application
fvm dart run bin/translations_code_gen.dart

# Analyze code
fvm dart analyze

# Run tests
fvm dart test
```

### Without FVM

If you prefer not to use FVM, ensure you have Dart SDK `3.9.2` or later installed:

```bash
# Check your Dart version
dart --version

# Run the application
dart run bin/translations_code_gen.dart
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Install dependencies with `fvm dart pub get` (or `dart pub get`)
4. Make your changes
5. Run tests and ensure code analysis passes
6. Commit your changes (`git commit -m 'Add some amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request
