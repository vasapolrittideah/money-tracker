import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared/src/storage/secure_storage.dart';

/// Manages encryption keys for Hive storage using [SecureStorage].
class HiveEncryption {
  HiveEncryption(this._hive, this._secureStorage);

  final HiveInterface _hive;
  final SecureStorage _secureStorage;
  Uint8List? _cachedKey;

  final String _key = 'encryption_key';

  /// Retrieves a secure encryption key for Hive storage.
  ///
  /// Returns a [Uint8List] representing the encryption key. The encryption key
  /// will be generated and stored securely if it does not already exist.
  Future<Uint8List> getSecureKey() async {
    if (_cachedKey != null) return _cachedKey!;

    var storedKey = await _secureStorage.get(_key);
    if (storedKey == null) {
      final newKey = _hive.generateSecureKey();
      storedKey = base64UrlEncode(newKey);
      await _secureStorage.set(_key, data: storedKey);
    }

    _cachedKey = base64Url.decode(storedKey);
    return _cachedKey!;
  }
}
