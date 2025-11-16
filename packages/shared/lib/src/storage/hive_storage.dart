import 'package:shared/src/storage/hive_encryption.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Manages key-value pairs using [Hive] with encryption support.
class HiveStorage<T> {
  HiveStorage(this._hive, this._encryption);

  final HiveInterface _hive;
  final HiveEncryption _encryption;
  final String _key = T.toString();

  Box<T>? _box;

  /// Ensures that the Hive box is opened and ready for operations.
  ///
  /// Returns the opened box of type [T]. If the box is not already open,
  /// it opens it with encryption.
  Future<Box<T>> get _ensureBox async {
    if (_box == null || !_box!.isOpen) {
      final encryptionKey = await _encryption.getSecureKey();
      _box = await _hive.openBox<T>(_key, encryptionCipher: HiveAesCipher(encryptionKey));
    }

    return _box!;
  }

  /// Stores a single [model] associated with the given [key].
  Future<void> storeItem(String key, T model) async {
    final box = await _ensureBox;
    await box.put(key, model);
  }

  /// Stores multiple [models] associated with the given list of [keys].
  ///
  /// Throws an [ArgumentError] if the lengths of [keys] and [models] do not match.
  Future<void> storeItems(List<String> keys, List<T> models) async {
    if (keys.length != models.length) {
      throw ArgumentError('Keys and models must have the same length');
    }

    final box = await _ensureBox;
    final map = Map.fromIterables(keys, models);
    await box.putAll(map);
  }

  /// Retrieves the item associated with the given [key].
  ///
  /// Returns the item of type [T] if it exists, otherwise returns `null`.
  Future<T?> getItem(String key) async {
    final box = await _ensureBox;
    return box.get(key);
  }

  /// Retrieves all items stored in the box as a list.
  ///
  /// Returns a list of items of type [T] or an empty list if the box is empty.
  Future<List<T>> getAllItems() async {
    final box = await _ensureBox;
    return box.values.toList();
  }

  /// Deletes the item associated with the given [key].
  ///
  /// If the key does not exist, this operation has no effect. Use with caution
  /// as this will remove the data and cannot be undone.
  Future<void> deleteItem(String key) async {
    final box = await _ensureBox;
    await box.delete(key);
  }

  /// Deletes all items stored in the box.
  ///
  /// If the box is empty, this operation has no effect. Use with caution as
  /// this will remove all data and cannot be undone.
  Future<void> deleteAllItems() async {
    final box = await _ensureBox;
    await box.clear();
  }

  /// Checks if the box contains an item associated with the given [key].
  ///
  /// Returns `true` if the item exists, otherwise returns `false`.
  Future<bool> containsKey(String key) async {
    final box = await _ensureBox;
    return box.containsKey(key);
  }

  /// Counts the number of items stored in the box.
  ///
  /// Returns the total count of items as an [int] or `0` if the box is empty.
  Future<int> get itemCount async {
    final box = await _ensureBox;
    return box.length;
  }

  /// Starts the Hive box by ensuring it is opened.
  Future<void> startBox() async {
    await _ensureBox;
  }

  /// Deletes the entire Hive box from disk if it is open.
  Future<void> closeBox() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
      _box = null;
    }
  }
}
