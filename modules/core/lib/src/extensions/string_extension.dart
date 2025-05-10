extension StringX on String {
  T? tryParse<T>() {
    if (T == bool) {
      return bool.fromEnvironment(this) as T;
    } else if (T == int) {
      return int.tryParse(this) as T?;
    } else if (T == double) {
      return double.tryParse(this) as T?;
    } else if (T == String) {
      return this as T;
    } else {
      return null;
    }
  }
}
