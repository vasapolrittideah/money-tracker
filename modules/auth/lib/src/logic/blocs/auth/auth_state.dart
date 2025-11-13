part of 'auth_bloc.dart';

@Freezed(fromJson: false, toJson: false)
abstract class AuthState with _$AuthState {
  const factory AuthState({@Default(AuthStatus.unknown) AuthStatus status}) = _AuthState;
}
