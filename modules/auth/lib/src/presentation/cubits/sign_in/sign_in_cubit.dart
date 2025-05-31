import 'package:auth/auth.dart';
import 'package:core/core.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInInitial());

  final AuthRepository _authRepository;

  Future<void> signIn({required String email, required String password}) async {
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.when(
      success: (_) => emit(SignInSuccess()),
      failure: (message) => emit(SignInFailure(message)),
    );
  }
}
