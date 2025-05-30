import 'dart:async';

import 'package:core/core.dart';
import 'package:core/src/data/local/primitive/primitive_keys.dart';
import 'package:core/src/data/local/token/token_storage_manager.dart';

final class TokenOperation {
  TokenOperation(this._tokenStorageManager) {
    _tokenStorageManager
        .read(PrimitiveKeys.tokenStorageKey)
        .then(_updateStatus);
  }

  final TokenStorageManager _tokenStorageManager;

  AuthStatus _authStatus = AuthStatus.unknown;

  Jwt? _token;

  final StreamController<AuthStatus> _controller =
      StreamController<AuthStatus>.broadcast()..add(AuthStatus.unknown);

  Future<Jwt?> get token async {
    if (_authStatus != AuthStatus.unknown) {
      return _token;
    }
    await authenticationStatus.firstWhere(
      (status) => status != AuthStatus.unknown,
    );
    return _token;
  }

  Stream<AuthStatus> get authenticationStatus async* {
    yield _authStatus;
    yield* _controller.stream;
  }

  Future<void> setToken(Jwt? token) async {
    if (token == null) {
      return clearToken();
    }
    await _tokenStorageManager.write(
      PrimitiveKeys.tokenStorageKey,
      data: token,
    );
    _updateStatus(token);
  }

  Future<void> revokeToken(Jwt? token) async {
    await _tokenStorageManager.delete(PrimitiveKeys.tokenStorageKey);
    if (_authStatus != AuthStatus.unauthenticated) {
      _authStatus = AuthStatus.unauthenticated;
      _controller.add(_authStatus);
    }
  }

  Future<void> clearToken() async {
    await _tokenStorageManager.delete(PrimitiveKeys.tokenStorageKey);
    _updateStatus(null);
  }

  Future<void> close() => _controller.close();

  void _updateStatus(Jwt? token) {
    _authStatus =
        token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    _token = token;
    _controller.add(_authStatus);
  }
}
