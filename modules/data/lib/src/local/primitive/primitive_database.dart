import 'package:data/src/local/primitive/primitive_keys.dart';

abstract class PrimitiveDatabase<T> {
  Future<T?> read(PrimitiveKeys key);
  Future<void> write(PrimitiveKeys key, {required T data});
  Future<void> delete(PrimitiveKeys key);
}
