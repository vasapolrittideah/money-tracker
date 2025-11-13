import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:auth/src/logic/cubits/login/login_cubit.dart';
import 'package:shared/shared.dart';

class AuthModule extends BaseModule {
  @override
  void setupDependencies() {
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));

    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  }
}
