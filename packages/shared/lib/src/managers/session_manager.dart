import 'dart:async';

import 'package:shared/shared.dart';

/// Manages user sessions using [HiveStorage].
class SessionManager {
  SessionManager(this._sessionStorage) {
    _init();
  }

  final HiveStorage<SessionModel> _sessionStorage;
  final String _key = 'session';

  SessionModel? _session;
  AuthStatus _authStatus = AuthStatus.unknown;
  final StreamController<AuthStatus> _controller = StreamController<AuthStatus>.broadcast();

  bool _isClosed = false;
  Future<void>? _initFuture;

  /// Initializes the session manager by loading the stored session and
  /// setting the auth status accordingly.
  Future<void> _init() async {
    _initFuture ??= _sessionStorage.getItem(_key).then((storedSession) {
      _setAuthStatus(storedSession);
    });

    return _initFuture!;
  }

  /// Returns the current session if available, otherwise `null`.
  ///
  /// If the auth status is unknown, it initializes the session manager first.
  Future<SessionModel?> get session async {
    if (_authStatus == AuthStatus.unknown) {
      await _init();
    }

    return _session;
  }

  /// Returns a stream of auth status updates.
  ///
  /// If the auth status is unknown, it initializes the session manager first.
  Stream<AuthStatus> get authStatus async* {
    if (_authStatus == AuthStatus.unknown) {
      await _init();
    }

    yield _authStatus;
    yield* _controller.stream;
  }

  /// Stores the given [session] and updates the auth status to authenticated.
  Future<void> storeSession(SessionModel session) async {
    await _sessionStorage.storeItem(_key, session);
    _setAuthStatus(session);
  }

  /// Removes the stored session and updates the auth status to unauthenticated.
  Future<void> clearSession() async {
    await _sessionStorage.deleteItem(_key);
    _setAuthStatus(null);
  }

  /// Closes the session manager and releases resources.
  Future<void> close() async {
    if (!_isClosed) {
      await _controller.close();
      _isClosed = true;
    }
  }

  /// Sets the current session and updates the auth status.
  ///
  /// If the given [session] is not null, the auth status is set to authenticated.
  /// Otherwise, it is set to unauthenticated. If the status changes, it emits
  /// the new status to the stream controller.
  void _setAuthStatus(SessionModel? session) {
    final newStatus = session != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;

    if (_authStatus != newStatus) {
      _authStatus = newStatus;
      if (!_isClosed && !_controller.isClosed) {
        _controller.add(_authStatus);
      }
    }

    _session = session;
  }
}
