import 'dart:convert';
import 'dart:typed_data';

import 'package:core/src/data/local/primitive/primitive_database.dart';
import 'package:core/src/data/local/primitive/primitive_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveEncryption {
  HiveEncryption(this._hive, this._primitiveDatabase);

  final HiveInterface _hive;
  final PrimitiveDatabase _primitiveDatabase;

  @visibleForTesting
  Uint8List? encryptionKey;

  Future<Uint8List> getSecureKey() async {
    if (this.encryptionKey != null) {
      return this.encryptionKey!;
    }

    var encryptionKeyString = await _primitiveDatabase.read(
      PrimitiveKeys.secureStorageKey,
    );
    if (encryptionKeyString == null) {
      final key = _hive.generateSecureKey();
      await _primitiveDatabase.write(
        PrimitiveKeys.secureStorageKey,
        data: base64UrlEncode(key),
      );

      encryptionKeyString = await _primitiveDatabase.read(
        PrimitiveKeys.secureStorageKey,
      );
    }

    final encryptionKey = base64Url.decode(encryptionKeyString);
    this.encryptionKey = encryptionKey;
    return encryptionKey;
  }
}
