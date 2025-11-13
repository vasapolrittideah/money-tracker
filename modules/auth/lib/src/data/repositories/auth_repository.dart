import 'package:auth/src/data/dtos/login/login_request.dart';
import 'package:auth/src/data/dtos/register/register_request.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract class IAuthRepository {
  Stream<AuthStatus> get status;
  Future<Either<AppFailure, Unit>> login(LoginRequest request);
  Future<Either<AppFailure, Unit>> register(RegisterRequest request);
}

class AuthRepository implements IAuthRepository {
  AuthRepository(this._dioClient) {
    _config = sl<AppConfig>();
  }

  final DioClient _dioClient;
  late final AppConfig _config;

  @override
  Stream<AuthStatus> get status => _dioClient.sessionManager.authStatus;

  @override
  Future<Either<AppFailure, Unit>> login(LoginRequest request) => ErrorHandler.handle(() async {
    final url = '${_config.apiBaseUrl}/auth/login';
    final response = await _dioClient.instance.post(url, data: request.toJson());

    await _dioClient.sessionManager.storeSession(
      SessionModel(accessToken: response.data['access_token'], refreshToken: response.data['refresh_token']),
    );

    return unit;
  });

  @override
  Future<Either<AppFailure, Unit>> register(RegisterRequest request) => ErrorHandler.handle(() async {
    final url = '${_config.apiBaseUrl}/auth/register';
    await _dioClient.instance.post(url, data: request.toJson());

    return unit;
  });
}
