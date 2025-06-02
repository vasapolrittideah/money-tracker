import 'package:auth/auth.dart';
import 'package:auth/src/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:auth/src/presentation/cubits/sign_up/sign_up_cubit.dart';
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
    sl.registerFactory(() => SignInCubit(sl()));
    sl.registerFactory(() => SignUpCubit(sl()));
  }
}
