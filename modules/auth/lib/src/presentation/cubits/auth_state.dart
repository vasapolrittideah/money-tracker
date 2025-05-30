part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  const AuthState._({this.status = AuthStatus.unknown, this.user = User.empty});

  final AuthStatus status;
  final User user;

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
    : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status];
}
