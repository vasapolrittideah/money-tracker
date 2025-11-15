import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:auth/src/data/repositories/oauth_repository.dart';
import 'package:auth/src/logic/blocs/auth/auth_bloc.dart';
import 'package:auth/src/logic/cubits/login/login_cubit.dart';
import 'package:auth/src/logic/cubits/oauth/oauth_cubit.dart';
import 'package:auth/src/logic/cubits/register/register_cubit.dart';
import 'package:shared/shared.dart';

class AuthModule extends BaseModule {
  @override
  void setupDependencies() {
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));

    sl.registerLazySingleton<IOAuthRepository>(() => OAuthRepository());

    sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

    sl.registerFactory<OAuthCubit>(() => OAuthCubit(sl()));

    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
  }
}
