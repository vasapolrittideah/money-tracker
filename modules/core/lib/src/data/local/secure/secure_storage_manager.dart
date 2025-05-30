import 'package:core/core.dart';
import 'package:core/src/data/local/primitive/primitive_database.dart';
import 'package:core/src/data/local/primitive/primitive_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager<T> extends PrimitiveDatabase<T> {
  SecureStorageManager(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  @override
  Future<T?> read(PrimitiveKeys key) async {
    try {
      final response = await _secureStorage.read(key: key.name);
      if (response == null || response.isEmpty) {
        return null;
      }

      return response.tryParse<T>();
    } catch (e) {
      await _secureStorage.deleteAll();
      return null;
    }
  }

  @override
  Future<void> write(PrimitiveKeys key, {required T data}) async {
    try {
      await _secureStorage.write(key: key.name, value: data.toString());
    } catch (e) {
      await _secureStorage.deleteAll();
      await _secureStorage.write(key: key.name, value: data.toString());
    }
  }

  @override
  Future<void> delete(PrimitiveKeys key) async {}
}
