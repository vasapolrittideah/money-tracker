import 'package:auth/auth.dart';
import 'package:core/core.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(SignUpInitial());

  final AuthRepository _authRepository;

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

    final result = await _authRepository.signUp(
      fullName: fullName,
      email: email,
      password: password,
    );

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      (failure) => emit(SignUpFailure(failure)),
      (_) => emit(SignUpSuccess()),
    );
  }
}
