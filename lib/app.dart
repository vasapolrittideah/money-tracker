import 'package:auth/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/src/app_module.dart';
import 'package:money_tracker/src/view/app_router.dart';
import 'package:settings/settings.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      designSize: const Size(360, 690),
      builder: (context, child) => EasyLocalization(
        path: AppModule.translationsAssets[0],
        supportedLocales: [Locale('th'), Locale('en')],
        fallbackLocale: Locale('th'),
        startLocale: Locale('th'),
        assetLoader: MultiPackageAssetLoader(AppModule.translationsAssets),
        saveLocale: false,
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.transparent,
                extensions: <ThemeExtension<dynamic>>[AppThemes(tokens: AppTokens.light)],
              ),
              builder: (context, child) => MultiBlocProvider(
                providers: [
                  BlocProvider<AuthBloc>(create: (_) => sl()),
                  BlocProvider<LocaleCubit>(create: (_) => sl()),
                ],
                child: child!,
              ),
            );
          },
        ),
      ),
    );
  }
}
