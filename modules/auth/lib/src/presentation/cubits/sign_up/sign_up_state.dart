part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

final class SignUpFailure extends SignUpState {
  const SignUpFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
