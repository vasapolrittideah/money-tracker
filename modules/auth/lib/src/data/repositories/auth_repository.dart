import 'dart:async';

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
  AuthRepository(this._dioClient);

  final DioClient _dioClient;
  final AppConfig _config = sl<AppConfig>();

  @override
  Stream<AuthStatus> get status => _dioClient.sessionManager.authStatus;

  @override
  Future<Either<AppFailure, Unit>> login(LoginRequest request) => ErrorHandler.handle(() async {
    final url = '${_config.apiBaseUrl}/auth/login';
    final dioResponse = await _dioClient.instance.post(url, data: request.toJson());
    final apiResponse = ApiResponse.fromJson(dioResponse.data);

    await _dioClient.sessionManager.storeSession(
      SessionModel(accessToken: apiResponse.data?['access_token'], refreshToken: apiResponse.data?['refresh_token']),
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
