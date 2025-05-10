import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final class FileOperationUtil {
  Future<String> createSubDirectory(String path) async {
    try {
      final newDirectory = await _fileDirectory(path);

      if (!newDirectory.existsSync()) {
        await newDirectory.create();
      }

      return newDirectory.path;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> removeSubDirectory(String path) async {
    try {
      final newDirectory = await _fileDirectory(path);

      if (newDirectory.existsSync()) {
        await newDirectory.delete();
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Directory> _fileDirectory(String path) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final dirPath = p.join(appDocPath, path);
    final newDirectory = Directory(dirPath);
    return newDirectory;
  }
}
