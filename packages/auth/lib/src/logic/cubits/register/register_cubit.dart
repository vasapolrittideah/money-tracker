import 'package:auth/src/data/dtos/register/register_request.dart';
import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(const RegisterState());

  final IAuthRepository _authRepository;

  Future<void> register(String email, String password) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final request = RegisterRequest(email: email, password: password);
    final result = await _authRepository.register(request);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false, failure: null)),
    );
  }
}
