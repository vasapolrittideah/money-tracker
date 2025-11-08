import 'package:shared/src/utilities/directory_util.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Manages Hive storage lifecycle.
class HiveManager {
  HiveManager(this._hive, this._directoryUtil);

  final HiveInterface _hive;
  final DirectoryUtil _directoryUtil;
  String get _subDirectory => 'hive_data';

  /// Initializes Hive by opening the storage.
  Future<void> init() async {
    await _open();
  }

  /// Clears all data stored in Hive and deletes the storage directory.
  Future<void> clear() async {
    await _hive.deleteFromDisk();
    await _directoryUtil.removeSubDirectory(_subDirectory);
  }

  /// Opens the Hive storage at the specified subdirectory.
  Future<void> _open() async {
    final subPath = await _directoryUtil.createSubDirectory(_subDirectory);
    await _hive.initFlutter(subPath);
  }
}
