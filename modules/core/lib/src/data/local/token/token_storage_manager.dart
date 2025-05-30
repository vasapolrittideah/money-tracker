import 'package:core/src/data/local/hive/hive_operation.dart';
import 'package:core/src/data/local/primitive/primitive_database.dart';
import 'package:core/src/data/local/primitive/primitive_keys.dart';
import 'package:core/src/models/jwt.dart';

class TokenStorageManager extends PrimitiveDatabase<Jwt> {
  TokenStorageManager(this._hiveOperation);

  final HiveOperation<Jwt> _hiveOperation;

  @override
  Future<void> delete(PrimitiveKeys key) => _hiveOperation.deleteItem(key.name);

  @override
  Future<Jwt?> read(PrimitiveKeys key) => _hiveOperation.getItem(key.name);

  @override
  Future<void> write(PrimitiveKeys key, {required Jwt data}) =>
      _hiveOperation.insertOrUpdateItem(key.name, data);
}
