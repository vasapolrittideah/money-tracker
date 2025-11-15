import 'package:auth/auth.dart';
import 'package:auth/gen/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/src/view/app_router.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          extensions: <ThemeExtension<dynamic>>[AppThemes(tokens: AppTokens.light)],
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SharedLocalizations.delegate,
          UILocalizations.delegate,
          AuthLocalizations.delegate,
        ],
        supportedLocales: SharedLocalizations.delegate.supportedLocales,
        builder: (context, child) => MultiBlocProvider(
          providers: [BlocProvider<AuthBloc>(create: (_) => sl()..add(AuthEvent.subscriptionRequested()))],
          child: child!,
        ),
      ),
    );
  }
}
