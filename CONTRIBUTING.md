# Contributing to translations_code_gen

Thanks for your interest in improving `translations_code_gen`.

## Setup

Requires Dart SDK 3.1 or newer.

```bash
dart pub get
```

## Checks to run before opening a PR

```bash
dart analyze --fatal-infos
dart format --output=none --set-exit-if-changed .
dart test
dart run bin/translations_code_gen.dart --help
```

CI runs the same checks on every pull request.

## Pull requests

- Keep changes focused; one topic per PR.
- Add or update tests for behavior changes.
- Update `CHANGELOG.md` for user-visible changes.

For security issues see [SECURITY.md](SECURITY.md).
