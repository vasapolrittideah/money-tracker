import 'package:auth/auth.dart';
import 'package:auth/src/models/requests/sign_in_request.dart';
import 'package:core/core.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInInitial());

  final AuthRepository _authRepository;

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    final result = await _authRepository.signIn(
      SignInRequest(email: email, password: password),
    );

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      (failure) => emit(SignInFailure(failure)),
      (_) => emit(SignInSuccess()),
    );
  }
}
