// ignore_for_file: avoid_print
import 'dart:io';

import 'package:shared/src/extensions/string_extension.dart';

void main(List<String> args) {
  final featureName = _validateAndGetFeatureName(args);
  _generateLocaleKeys(featureName);
  _renameLocaleKeysClass(featureName);

  print('🎉 Locale keys file generated successfully for feature "$featureName"!');
}

String _validateAndGetFeatureName(List<String> args) {
  if (args.isEmpty) {
    print('❌ Please provide a feature name.');
    exit(1);
  }

  return args[0].toCapitalized();
}

void _generateLocaleKeys(String featureName) {
  final result = Process.runSync('dart', [
    'run',
    'easy_localization:generate',
    '--format',
    'keys',
    '--source-dir',
    'assets/translations',
    '--output-file',
    'locale_keys.g.dart',
    '--output-dir',
    'lib/generated',
    '--skip-unnecessary-keys',
    'true',
  ], runInShell: true);

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  if (result.exitCode != 0) {
    print('❌ Failed to generate locale keys file.');
    exit(result.exitCode);
  }
}

void _renameLocaleKeysClass(String featureName) {
  final generatedFile = File('${Directory.current.path}/lib/generated/locale_keys.g.dart');
  if (generatedFile.existsSync()) {
    var content = generatedFile.readAsStringSync();
    content = content.replaceAll('LocaleKeys {', '${featureName}LocaleKeys {');
    generatedFile.writeAsStringSync(content);
  }
}
