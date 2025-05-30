import 'package:core/core.dart';

class AuthRepository {
  const AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Stream<AuthStatus> get status =>
      _apiClient.tokenOperation.authenticationStatus;

  Future<Result<void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email, 'password': password};

      final response = await _apiClient.httpClient.post(
        '${AppConfig.authApiUrl}/api/auth/login',
        data: body,
      );

      await _apiClient.tokenOperation.setToken(Jwt(accessToken: response.data));

      return Result.success(null);
    } on Exception catch (error) {
      return Result.failure(error.toString());
    }
  }
}
