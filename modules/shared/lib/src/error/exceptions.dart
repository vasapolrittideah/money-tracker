/// Thrown when there is an error with local storage operations.
class LocalStorageException implements Exception {
  const LocalStorageException([this.message]);

  final String? message;

  @override
  String toString() {
    return message != null ? 'LocalStorageException: $message' : 'LocalStorageException';
  }
}
