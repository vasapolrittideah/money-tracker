// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final targetDir = Directory('lib/gen/l10n');

  // Supported locales
  final supportedLocales = ['en', 'th'];
  final Map<String, List<File>> localizationSources = {for (var locale in supportedLocales) 'intl_$locale.arb': []};

  // Collect directories to search
  final searchDirs = await _buildSearchDirs();

  // Search all .arb files
  print('🔎 Searching for .arb files...');
  for (var path in searchDirs) {
    final dir = Directory(path);
    if (dir.existsSync()) {
      await _collectArbFiles(dir, localizationSources);
    }
  }

  // Ensure target directory exists
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  // Merge .arb files per locale
  for (final entry in localizationSources.entries) {
    final mergedFile = File('${targetDir.path}/${entry.key}');
    final locale = entry.key.replaceAllMapped(RegExp(r'intl_(.+)\.arb'), (match) => match.group(1)!);

    Map<String, dynamic> mergedContent = {'@@locale': locale};

    for (final file in entry.value) {
      try {
        final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        content.remove('@@locale'); // Prevent accidental overwrite
        mergedContent.addAll(content);
      } catch (e) {
        print('🚨 Failed reading ${file.path}: $e');
      }
    }

    // Sort for readability
    final sorted = Map.fromEntries(mergedContent.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    await mergedFile.writeAsString(JsonEncoder.withIndent('  ').convert(sorted));

    print('✅ Merged: ${mergedFile.path}');
  }

  // Run localization generator
  print('\n🚀 Running localization generator...');

  final result = await Process.run('dart', ['run', 'intl_utils:generate'], runInShell: true);

  if ((result.stderr as String).isNotEmpty) {
    stderr.writeln('⚠️ Error: ${result.stderr}');
  }
  if ((result.stdout as String).isNotEmpty) {
    stdout.writeln(result.stdout);
  }

  print('🎉 Localization merge complete!');
}

/// Dynamically build list of directories to search for `.arb` files
Future<List<String>> _buildSearchDirs() async {
  final localizationDirs = <String>[];

  final dir = Directory('lib/src');
  await for (var entity in dir.list(recursive: true)) {
    if (entity is Directory && entity.path.endsWith('l10n')) {
      localizationDirs.add(entity.path);
    }
  }

  return localizationDirs;
}

/// Collects `.arb` files and associates them with locale keys
Future<void> _collectArbFiles(Directory dir, Map<String, List<File>> localizationFiles) async {
  await for (final entity in dir.list(recursive: true, followLinks: false)) {
    if (entity is File) {
      final fileName = entity.uri.pathSegments.last;
      final match = RegExp(r'[a-z]+_([a-z]{2})\.arb').firstMatch(fileName);

      if (match != null) {
        final locale = match.group(1)!;
        final targetKey = 'intl_$locale.arb';

        if (localizationFiles.containsKey(targetKey)) {
          localizationFiles[targetKey]!.add(entity);
          print('📦 Found $targetKey: ${entity.path}');
        }
      }
    }
  }
}
