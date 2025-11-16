part of 'register_cubit.dart';

@Freezed(fromJson: false, toJson: false)
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({@Default(false) bool isLoading, @Default(null) Failure? failure}) = _RegisterState;
}
