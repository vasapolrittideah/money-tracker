import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores key-value pairs securely using [FlutterSecureStorage].
class SecureStorage {
  SecureStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Retrieves the value associated with the given [key].
  ///
  /// Returns the value as a [String] if it exists, otherwise returns `null`.
  /// If an error occurs during retrieval, the entire secure storage is cleared
  /// to prevent corruption and `null` is returned.
  Future<String?> get(String key) async {
    try {
      final response = await _secureStorage.read(key: key);
      return (response?.isEmpty ?? true) ? null : response;
    } catch (_) {
      await _secureStorage.deleteAll();
      return null;
    }
  }

  /// Stores the [data] associated with the given [key].
  ///
  /// If an error occurs during storage, the entire secure storage is cleared
  /// and the data is attempted to be stored again.
  Future<void> set(String key, {required String data}) async {
    try {
      await _secureStorage.write(key: key, value: data);
    } catch (_) {
      await _secureStorage.deleteAll();
      await _secureStorage.write(key: key, value: data);
    }
  }

  /// Deletes the value associated with the given [key].
  ///
  /// If the key does not exist, this operation has no effect.
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
}
