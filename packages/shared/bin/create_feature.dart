// ignore_for_file: avoid_print

import 'dart:io';

import 'package:shared/src/extensions/string_extension.dart';

const packagesDir = './packages';
const featureNamePattern = r'^[a-zA-Z_]+$';
const folderPaths = [
  'data/dtos',
  'data/repositories',
  'logic/blocs',
  'logic/cubits',
  'view/overlays',
  'view/screens',
  'view/widgets',
];

Future<void> main(List<String> args) async {
  final featureName = _validateAndGetFeatureName(args);
  _ensureFeatureNotExist(featureName);

  _createFlutterPackage(featureName);
  _cleanupDartFiles(featureName);

  final folderStructure = _createFolderStructure(featureName);
  _writeReadmeFile(featureName, folderStructure);
  _writePubspecYaml(featureName);
  _appendGitignoreFile(featureName);
  _createTranslationFiles(featureName);

  _appendWorkspaceToRootPubspec(featureName);
  _installDependencies(featureName);

  print('🎉 Feature package "$featureName" created successfully!');
}

String _validateAndGetFeatureName(List<String> args) {
  if (args.isEmpty) {
    print('❌ Please provide a feature name.');
    exit(1);
  }

  final featureName = args[0].toLowerCase();
  final validNameRegExp = RegExp(featureNamePattern);

  if (!validNameRegExp.hasMatch(featureName)) {
    print('❌ Invalid feature name: "$featureName".');
    print('Feature name must contain only letters and underscores, no numbers.');
    exit(1);
  }

  return featureName;
}

void _ensureFeatureNotExist(String featureName) {
  final directory = Directory('$packagesDir/$featureName');
  if (directory.existsSync()) {
    print('❌ Feature package "$featureName" already exists.');
    exit(1);
  }
}

void _createFlutterPackage(String featureName) {
  final result = Process.runSync('flutter', [
    'create',
    '--template=package',
    '$packagesDir/$featureName',
  ], runInShell: true);

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  if (result.exitCode != 0) {
    print('❌ Failed to create feature package "$featureName".');
    exit(result.exitCode);
  }
}

void _cleanupDartFiles(String featureName) {
  final directory = Directory('$packagesDir/$featureName');
  final deletedFiles = <String>[];

  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      deletedFiles.add(entity.path);
      entity.deleteSync();
    }
  }

  print('🧹 Removed ${deletedFiles.length} Dart file(s):');
  for (final f in deletedFiles) {
    print('   - $f');
  }
}

String _createFolderStructure(String featureName) {
  final libDir = Directory('$packagesDir/$featureName/lib');
  final srcDir = Directory('${libDir.path}/src');

  // Create all folders
  for (final path in folderPaths) {
    Directory('${srcDir.path}/$path').createSync(recursive: true);
  }

  // Create feature module and main files
  final featureModuleFile = File('${srcDir.path}/${featureName}_module.dart');
  featureModuleFile.createSync(recursive: true);
  featureModuleFile.writeAsStringSync('''
import 'package:shared/shared.dart';

class ${featureName.toCapitalized()}Module extends BaseModule {
  @override
  String get name => '$featureName';

  @override
  void setupDependencies() {
    // TODO: add dependency injections here
  }
}
''');

  final featureFile = File('$packagesDir/$featureName/lib/$featureName.dart');
  featureFile.createSync(recursive: true);
  featureFile.writeAsStringSync('''
export 'src/${featureName}_module.dart';
''');

  final routerFile = File('${srcDir.path}/view/${featureName}_router.dart');
  routerFile.createSync(recursive: true);
  routerFile.writeAsStringSync('''
import 'package:shared/libs.dart';

class ${featureName.toCapitalized()}RouteName {

}

class ${featureName.toCapitalized()}Router {
  static List<GoRoute> get routes => [

  ];
}

''');

  final folderStructure =
      '''
📁 Folder structure created for $featureName package:

$featureName/
├── assets/
│   └── translations/           # JSON translation files
└── lib/
    ├── src/
    │   ├── data/               # Data layer - external data sources
    │   │   ├── dtos/           # Data Transfer Objects - serialization models
    │   │   └── repositories    # Data access - API calls & local storage
    │   ├── logic/              # Business logic layer - state & app logic
    │   │   ├── blocs/          # BLoC pattern - complex state management
    │   │   └── cubits/         # Cubit pattern - simplified state management
    │   ├── view/               # Presentation layer - UI components
    │   │   ├── overlays/       # Modal overlays - dialogs, bottom sheets
    │   │   ├── screens/        # Full-screen views - app pages
    │   │   └── widgets/        # Reusable UI components
    │   └── ${featureName}_module.dart
    └── $featureName.dart
''';

  print(folderStructure);

  return folderStructure;
}

void _writeReadmeFile(String featureName, String folderStructure) {
  final readmeFile = File('$packagesDir/$featureName/README.md');

  readmeFile.createSync(recursive: true);
  readmeFile.writeAsStringSync('''

# ${featureName.toCapitalized()} Feature Package

This package implements the **$featureName** feature for Money Tracker application.

## Folder Structure

```text
$folderStructure
```

## Layer Responsibilities

### **Data Layer**: Handle all external data sources and data transformation

Responsibilities:
- Fetch data from REST APIs or databases
- Read/write to local storage (Hive)
- Transform raw data into app-friendly models
- Handle network requests and responses
- Handle data caching and offline support
- Perform data validation and error handling

Components:
- DTOs (Data Transfer Objects): JSON serialization models matching API contracts
- Repositories: Data access components that communicate with server or local storage and provide data or failures to logic layer

### **Logic Layer**: Manage application state and business logic

Responsibilities:
- Process and validate user inputs
- Execute business rules and calculations
- Coordinate data flow between layers
- Manage feature-specific state
- Handle side effects (e.g., API calls, local storage)
- Emit UI states besed on data and user actions

Components:
- BLoCs: Complex state management with event-driven architecture (good for features with multiple triggers)
- Cubits: Simple state management with direct method calls (good for straightforward state changes)

### **View Layer**: Build the user interface and handle user interactions

Responsibilities:
- Build widget trees and UI components
- Display data from state management
- Capture user interactions (e.g., taps, gestures, inputs)
- Handle UI-specific logic (e.g., animations, form validation)
- Manage localization and translations
- Manage navigation and routing between screens
- Apply consistent theming and styling

Components:
- Overlays: Modal components like dialogs and bottom sheets
- Screens: Full-screen views representing app pages
- Widgets: Reusable UI components used across screens

## Usage

Include this package to use **$featureName** feature in `pubspec.yaml`:

```yaml
dependencies:
  $featureName:
    path: ../$featureName
```

Then, import the package where needed:

```dart
import 'package:$featureName/$featureName.dart';
```
''');

  print('📝 README.md created.');
}

void _writePubspecYaml(String featureName) {
  final pubspecFile = File('$packagesDir/$featureName/pubspec.yaml');

  pubspecFile.createSync(recursive: true);
  pubspecFile.writeAsStringSync('''
name: $featureName
description: $featureName feature package for Money Tracker application.
version: 0.0.1
publish_to: "none"
resolution: "workspace"

environment:
  sdk: ^3.9.2
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter
  shared:
    path: ../shared
  ui:
    path: ../ui

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.10.1
  freezed: ^3.2.3
  json_serializable: ^6.11.1

flutter:
  assets:
    - ./assets/translations/
''');

  print('📝 pubspec.yaml created.');
}

void _appendGitignoreFile(String featureName) {
  final gitignoreFile = File('$packagesDir/$featureName/.gitignore');
  gitignoreFile.createSync(recursive: true);
  gitignoreFile.writeAsStringSync('''
# Flutter/Dart generated files
*.g.dart
*.freezed.dart
*.mocks.dart
*.gr.dart
*.config.dart
gen/
''', mode: FileMode.append);

  print('📝 .gitignore updated.');
}

void _createTranslationFiles(String featureName) {
  final translationsDir = Directory('$packagesDir/$featureName/assets/translations');
  translationsDir.createSync(recursive: true);

  _createTranslationFile(translationsDir, 'en');
  _createTranslationFile(translationsDir, 'th');

  print('🌐 Translation files created in ${translationsDir.path}');
}

void _createTranslationFile(Directory translationsDir, String languageCode) {
  final jsonFile = File('${translationsDir.path}/$languageCode.json');
  jsonFile.writeAsStringSync('{}');
}

void _appendWorkspaceToRootPubspec(String featureName) {
  final rootPubspecFile = File('./pubspec.yaml');
  final content = rootPubspecFile.readAsStringSync();
  final lines = content.split('\n');

  // Find the workspace section
  int workspaceIndex = -1;
  int lastWorkspaceEntryIndex = -1;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().startsWith('workspace:')) {
      workspaceIndex = i;
    } else if (workspaceIndex != -1 && lines[i].trim().startsWith('- packages/')) {
      lastWorkspaceEntryIndex = i;
    } else if (workspaceIndex != -1 &&
        lastWorkspaceEntryIndex != -1 &&
        lines[i].isNotEmpty &&
        !lines[i].trim().startsWith('- packages/')) {
      // Found the workspace section end
      break;
    }
  }

  final newWorkspaceEntry = '  - packages/$featureName';

  // Check if entry already exists
  if (content.contains(newWorkspaceEntry)) {
    print('ℹ️  Workspace entry for "$featureName" already exists in root pubspec.yaml.');
    return;
  }

  // Insert after the last workspace entry
  lines.insert(lastWorkspaceEntryIndex + 1, newWorkspaceEntry);

  rootPubspecFile.writeAsStringSync(lines.join('\n'));
  print('✅ Added "$featureName" to workspace in root pubspec.yaml');
}

void _installDependencies(String featureName) {
  ProcessResult result = Process.runSync(
    'flutter',
    ['pub', 'get'],
    runInShell: true,
    workingDirectory: '$packagesDir/$featureName',
  );

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  if (result.exitCode != 0) {
    print('❌ Failed to install dependencies for feature package "$featureName".');
    exit(result.exitCode);
  }

  // Also run pub get in the root to ensure workspace dependencies are resolved
  result = Process.runSync('flutter', ['pub', 'get'], runInShell: true, workingDirectory: '.');

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  if (result.exitCode != 0) {
    print('❌ Failed to install root dependencies.');
    exit(result.exitCode);
  }
}
