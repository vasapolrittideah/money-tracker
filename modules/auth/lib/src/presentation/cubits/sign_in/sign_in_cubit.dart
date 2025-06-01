import 'package:auth/auth.dart';
import 'package:core/core.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInInitial());

  final AuthRepository _authRepository;

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(SignInFailure(failure)),
      (_) => emit(SignInSuccess()),
    );
  }
}
