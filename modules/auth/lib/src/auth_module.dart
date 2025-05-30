import 'package:auth/auth.dart';
import 'package:core/core.dart';

class AuthModule extends BaseModule {
  static final AuthModule _instance = AuthModule._internal();

  factory AuthModule() => _instance;

  AuthModule._internal();

  @override
  void init() {
    register();
  }

  @override
  void register() {
    sl.registerLazySingleton(() => AuthRepository(sl()));
    sl.registerFactory(() => AuthCubit(sl(), sl()));
  }
}
