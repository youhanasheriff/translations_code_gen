## 1.3.6

- **Public Constant Accessibility**: Major API enhancement making translation constants publicly accessible:
  - **Public Constants**: Removed private modifiers from all translation key constants (changed from `_CONSTANT_NAME` to `CONSTANT_NAME`)
  - **Direct Access**: Translation key constants are now publicly accessible for direct usage and testing
  - **Flexible Usage**: Developers can now choose between generated methods or direct constant access
  - **Testing Support**: Public constants enable easier unit testing and debugging of translation keys
  - **Custom Logic**: Enhanced integration capabilities for custom translation logic and third-party tools
  - **Backward Compatibility**: Generated methods remain unchanged, ensuring existing code continues to work
- **Documentation**: Updated README.md with comprehensive examples and usage patterns for public constants
- **Developer Experience**: Improved flexibility and accessibility of generated translation code

## 1.3.5

- **Documentation Enhancement**: Comprehensive README.md improvements with detailed placeholder examples:
  - **Named Placeholders**: Added examples for `{name}`, `{username}`, `{timeOfDay}` placeholders
  - **Positional Placeholders**: Included examples for positional `{}` placeholders
  - **Mixed Scenarios**: Demonstrated complex scenarios combining named and positional placeholders
  - **Multilingual Examples**: Enhanced JSON examples in both English and Arabic
  - **Generated Code Examples**: Added comprehensive examples of generated Dart code for all placeholder types
  - **Usage Examples**: Included practical Flutter widget usage examples
  - **Feature Documentation**: Added detailed section explaining all placeholder types and their usage patterns
- **Code Examples**: Updated all code examples to reflect real-world usage scenarios
- **Developer Experience**: Improved documentation clarity for better understanding of package capabilities

## 1.3.3

- **Documentation**: Added comprehensive API documentation generated with dart doc
- **Code Quality**: Improved code structure and organization
- **Maintenance**: Updated package metadata and consistency improvements

## 1.3.2

- **Code Generation Improvements**: Major refactoring of generated translation code structure:
  - **Private Constants**: Changed all translation constants to private const variables for better encapsulation
  - **Public Methods**: Implemented public getter methods for all translation variables, including those without placeholders
  - **Named Parameters**: Added named parameter methods for variables containing placeholders to improve code readability and type safety
  - **Positional Parameters**: Included positional list parameters to handle unnamed arguments for placeholder variables, providing flexible parameter passing options
- **API Enhancement**: These changes improve the generated code's maintainability, type safety, and developer experience
- **Backward Compatibility**: Updated method signatures provide more intuitive and flexible ways to access translations
- **Version Update**: Updated package version from 1.2.2 to 1.3.2.
- **Documentation**: Updated README.md with latest version reference.
- **Error Messages**: Updated error messages to reflect current version.
- **Maintenance**: General maintenance and version consistency improvements.

## 1.2.2

- **Major Dependency Upgrades**: Updated all dependencies to their latest stable versions.
- **SDK Upgrade**: Updated Dart SDK from `3.1.0` to `3.9.2` (latest stable).
- **Flutter SDK**: Added FVM support with Flutter `3.35.4` (includes Dart `3.9.2`).
- **Dependencies Updated**:
  - `settings_yaml`: `^7.0.0` → `^8.3.1` (major version upgrade)
  - `lints`: `^2.0.0` → `^6.0.0` (major version upgrade)
- **Development**: Added FVM configuration for better version management.
- **Compatibility**: Verified compatibility with latest Dart SDK and all upgraded dependencies.

## 1.2.1

- Updated Dart SDK to `Dart SDK version: 3.1.0 (stable)`.
- Updated `settings_yaml` from `^5.0.0` to `^7.0.0`.

## 1.2.0

- Added support for generating modes with the '-g' or '--generate' flag.
- Added 4 generation modes: 'dart', 'dart-keys, 'dart-values', 'json-values'.
- Added few more error checks.
- Added more error messages.

## 1.1.1

- Removed extra print code.

## 1.1.0

- Added support for generating translations from a directory and file with configuration.
- Added support for translations_code_gen.yaml file.

## 1.0.7

- Renamed lib/code_gen.dart to lib/translations_code_gen.dart.

## 1.0.6

- Fixed double quotes and new line error when generating values.

## 1.0.5

- Modified the `README.md` file.

## 1.0.4

- Added info print statements.

## 1.0.3

- Added values to generate from the directory.

## 1.0.2

- Updated the `README.md` file.

## 1.0.1

- Fix a bug in the `global activate` command.

## 1.0.0

- Initial version.
