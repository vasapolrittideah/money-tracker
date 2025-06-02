import 'package:core/core.dart';

class AuthRepository {
  const AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Stream<AuthStatus> get status =>
      _apiClient.tokenOperation.authenticationStatus;

  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email, 'password': password};

      final response = await _apiClient.httpClient.post(
        '${AppConfig.authApiUrl}/api/auth/sign-in',
        data: body,
      );

      await _apiClient.tokenOperation.setToken(Jwt(accessToken: response.data));

      return right(unit);
    } on Exception catch (error) {
      return left(ErrorHandlerUtil.handleError(error));
    }
  }

  Future<Either<Failure, Unit>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'full_name': fullName,
        'email': email,
        'password': password,
      };

      await _apiClient.httpClient.post(
        '${AppConfig.authApiUrl}/api/auth/sign-up',
        data: body,
      );

      return right(unit);
    } on Exception catch (error) {
      return left(ErrorHandlerUtil.handleError(error));
    }
  }
}
