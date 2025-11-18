/// Thrown when there is an error during cache operations.
class CacheException implements Exception {
  const CacheException([this.message]);

  final String? message;

  @override
  String toString() {
    return message != null ? 'CacheException: $message' : 'CacheException';
  }
}

/// Thrown when there is an error during Facebook sign-in.
class FacebookSignInException implements Exception {
  const FacebookSignInException([this.message]);

  final String? message;

  @override
  String toString() {
    return message != null ? 'FacebookSignInException: $message' : 'FacebookSignInException';
  }
}
