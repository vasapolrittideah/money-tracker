import 'package:auth/src/models/requests/sign_in_request.dart';
import 'package:auth/src/models/requests/sign_up_request.dart';
import 'package:core/core.dart';

class AuthRepository {
  const AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Stream<AuthStatus> get status =>
      _apiClient.tokenOperation.authenticationStatus;

  Future<Either<Failure, Unit>> signIn(SignInRequest request) async {
    try {
      final response = await _apiClient.httpClient.post(
        '${AppConfig.authApiUrl}/api/auth/sign-in',
        data: request.toJson(),
      );

      await _apiClient.tokenOperation.setToken(Jwt(accessToken: response.data));

      return right(unit);
    } on Exception catch (error) {
      return left(ErrorHandlerUtil.handleError(error));
    }
  }

  Future<Either<Failure, Unit>> signUp(SignUpRequest request) async {
    try {
      await _apiClient.httpClient.post(
        '${AppConfig.authApiUrl}/api/auth/sign-up',
        data: request.toJson(),
      );

      return right(unit);
    } on Exception catch (error) {
      return left(ErrorHandlerUtil.handleError(error));
    }
  }
}
