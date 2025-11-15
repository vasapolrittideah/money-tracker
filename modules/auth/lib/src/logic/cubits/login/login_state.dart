part of 'login_cubit.dart';

@Freezed(fromJson: false, toJson: false)
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(false) bool isLoading, @Default(null) Failure? failure}) = _LoginState;
}
