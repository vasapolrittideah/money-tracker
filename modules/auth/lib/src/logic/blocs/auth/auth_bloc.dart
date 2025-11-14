import 'dart:async';

import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState(status: AuthStatus.unknown)) {
    on<AuthSubscriptionRequested>(_onSubscribtionRequest);
  }

  final IAuthRepository _authRepository;

  Future<void> _onSubscribtionRequest(AuthSubscriptionRequested event, Emitter<AuthState> emit) async {
    await emit.forEach<AuthStatus>(
      _authRepository.status,
      onData: (status) {
        switch (status) {
          case AuthStatus.authenticated:
            return AuthState(status: AuthStatus.authenticated);
          case AuthStatus.unauthenticated:
            return AuthState(status: AuthStatus.unauthenticated);
          case AuthStatus.unknown:
            return AuthState(status: AuthStatus.unknown);
        }
      },
      onError: (_, __) => AuthState(status: AuthStatus.unknown),
    );
  }
}
