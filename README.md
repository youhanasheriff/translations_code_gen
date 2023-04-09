# Translations code generator

<p align="center">
  <a href="https://pub.dev/packages/translations_code_gen">
    <img src="https://img.shields.io/pub/v/translations_code_gen?translations_code_gen=pub.dev&labelColor=333940&logo=dart">
  </a>
  <a href="https://t.me/youhanasheriff">
    <img src="https://img.shields.io/static/v1?label=join&message=Hey dev!&labelColor=333940&logo=telegram&logoColor=white&color=229ED9">
  </a>
  <a href="https://twitter.com/youhanasheriff">
    <img src="https://img.shields.io/twitter/follow/youhanasheriff?style=flat&label=Follow&color=1DA1F2&labelColor=333940&logo=twitter&logoColor=fff">
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
  translations_code_gen: ^1.1.0
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
    "WELCOME": "Welcome"
  },
  "HOME": {
    "TITLE": "Home"
  }
}
```

example: `assets/translations/ar.json`

```json
{
  "GENERAL": {
    "HELLO": "مرحبا",
    "WELCOME": "أهلا بك"
  },
  "HOME": {
    "TITLE": "الرئيسية"
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

This will generate the following keys to the `lib/translations/keys.dart` file:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names, camel_case_types

class GENERAL {
  static const String HELLO = "GENERAL.HELLO";
  static const String WELCOME = "GENERAL.WELCOME";
}

class HOME {
  static const String TITLE = "HOME.TITLE";
}
```

and the following values to the `en.dart` and `ar.dart` file to `lib/translations/values/`

example: `lib/translations/values/en.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names

import '../keys.dart'; // sometimes you need to change this path to match your project structure

const Map<String, String> _general  = {
  GENERAL.HELLO: "Hello",
  GENERAL.WELCOME: "Welcome",
};

const Map<String, String> _home  = {
  HOME.TITLE: "Home",
};

final Map<String, String> enValues = {
  ..._general,
  ..._home,
};
```

example: `lib/translations/values/ar.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names

import '../keys.dart'; // sometimes you need to change this path to match your project structure

const Map<String, String> _general  = {
  GENERAL.HELLO: "مرحبا",
  GENERAL.WELCOME: "أهلا بك",
};

const Map<String, String> _home  = {
  HOME.TITLE: "الرئيسية",
};

final Map<String, String> enValues = {
  ..._general,
  ..._home,
};
```

You might have to change the keys import path to match your project structure.

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
        title: Text(HOME.TITLE.tr()),
      ),
      body: Center(
        child: Text(GENERAL.HELLO.tr()),
      ),
    );
  }
}
```
