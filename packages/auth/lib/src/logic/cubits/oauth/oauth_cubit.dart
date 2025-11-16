import 'package:auth/src/data/repositories/oauth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'oauth_cubit.freezed.dart';
part 'oauth_state.dart';

class OAuthCubit extends Cubit<OAuthState> {
  OAuthCubit(this._oauthRepository) : super(const OAuthState());

  final IOAuthRepository _oauthRepository;

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _oauthRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false, failure: null)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _oauthRepository.signInWithFacebook();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false, failure: null)),
    );
  }
}
