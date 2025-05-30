import 'package:auth/src/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:user/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._userRepository)
    : super(const AuthState.unknown());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> subscribeToAuthChanges() async {
    _authRepository.status.listen((status) async {
      switch (status) {
        case AuthStatus.authenticated:
          var user = await _userRepository.getCurrentUser();
          user ??= User.empty;

          return emit(AuthState.authenticated(user));

        case AuthStatus.unauthenticated:
          return emit(const AuthState.unauthenticated());

        case AuthStatus.unknown:
          return emit(const AuthState.unknown());
      }
    }, onError: addError);
  }
}
