part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {
  const SignInInitial();
}

final class SignInLoading extends SignInState {
  const SignInLoading();
}

final class SignInSuccess extends SignInState {
  const SignInSuccess();
}

final class SignInFailure extends SignInState {
  const SignInFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
