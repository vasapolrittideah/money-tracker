import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Manages directories within the application's document directory.
class DirectoryUtil {
  /// Creates a subdirectory at the given [path].
  ///
  /// Returns the full path of the created subdirectory. If the directory already
  /// exists, it simply returns the existing path.
  Future<String> createSubDirectory(String path) async {
    final directory = await _resolveDirectory(path);

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory.path;
  }

  /// Removes the subdirectory at the given [path].
  ///
  /// Returns `true` if the directory was successfully removed or did not exist,
  /// and `false` if an error occurred during the process.
  Future<bool> removeSubDirectory(String path) async {
    try {
      final directory = await _resolveDirectory(path);

      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Resolves the given [subPath] to a [Directory].
  ///
  /// Combines the application's document directory with the provided [subPath]
  /// and returns the resulting [Directory] object.
  Future<Directory> _resolveDirectory(String subPath) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dirPath = p.join(appDocDir.path, subPath);

    return Directory(dirPath);
  }
}
