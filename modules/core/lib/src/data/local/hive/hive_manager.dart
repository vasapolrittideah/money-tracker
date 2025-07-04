import 'package:core/core.dart';

class HiveManger {
  HiveManger(this._hive, {FileOperationUtil? fileOperationHelper})
    : _fileOperationHelper = fileOperationHelper ?? FileOperationUtil();

  final HiveInterface _hive;
  late final FileOperationUtil _fileOperationHelper;
  String get _subDirectory => 'hive';

  Future<void> init() async {
    await _open();
  }

  Future<void> clear() async {
    await _hive.deleteFromDisk();
    await _fileOperationHelper.removeSubDirectory(_subDirectory);
  }

  Future<void> _open() async {
    final subPath = await _fileOperationHelper.createSubDirectory(
      _subDirectory,
    );
    await _hive.initFlutter(subPath);
  }
}
