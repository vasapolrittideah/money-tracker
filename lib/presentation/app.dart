import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/modules/app_module.dart';
import 'package:money_tracker/presentation/app_router.dart';
import 'package:ui/ui.dart';

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AppConfig.init();
  await AppModule.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(lazy: false, create: (_) => sl()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.transparent,
              extensions: <ThemeExtension<dynamic>>[
                AppTheme(tokens: AppTokens.light),
              ],
            ),
            builder: (context, child) => MainAppInner(child: child!),
          ),
        );
      },
    );
  }
}

class MainAppInner extends HookWidget {
  const MainAppInner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authCubit = useBloc<AuthCubit>();

    useBlocListener<AuthCubit, AuthState>(
      authCubit,
      (cubit, value, context) => AppRouter.router.refresh(),
    );

    return child;
  }
}
