import 'dart:async';

import 'package:core/core.dart';
import 'package:data/src/local/primitive/primitive_keys.dart';
import 'package:data/src/local/token/token_storage_manager.dart';
import 'package:data/src/models/jwt/jwt.dart';

final class TokenOperation {
  TokenOperation(this._tokenStorageManager) {
    _tokenStorageManager
        .read(PrimitiveKeys.tokenStorageKey)
        .then(_updateStatus);
  }

  final TokenStorageManager _tokenStorageManager;

  AuthenticationStatus _authenticationStatus = AuthenticationStatus.unknown;

  Jwt? _token;

  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>.broadcast()
        ..add(AuthenticationStatus.unknown);

  Future<Jwt?> get token async {
    if (_authenticationStatus != AuthenticationStatus.unknown) {
      return _token;
    }
    await authenticationStatus.firstWhere(
      (status) => status != AuthenticationStatus.unknown,
    );
    return _token;
  }

  Stream<AuthenticationStatus> get authenticationStatus async* {
    yield _authenticationStatus;
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
    if (_authenticationStatus != AuthenticationStatus.unauthenticated) {
      _authenticationStatus = AuthenticationStatus.unauthenticated;
      _controller.add(_authenticationStatus);
    }
  }

  Future<void> clearToken() async {
    await _tokenStorageManager.delete(PrimitiveKeys.tokenStorageKey);
    _updateStatus(null);
  }

  Future<void> close() => _controller.close();

  void _updateStatus(Jwt? token) {
    _authenticationStatus =
        token != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated;
    _token = token;
    _controller.add(_authenticationStatus);
  }
}
