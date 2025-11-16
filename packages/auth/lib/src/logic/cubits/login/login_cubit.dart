import 'package:auth/src/data/dtos/login/login_request.dart';
import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final IAuthRepository _authRepository;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final request = LoginRequest(email: email, password: password);
    final result = await _authRepository.login(request);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false, failure: null)),
    );
  }
}
