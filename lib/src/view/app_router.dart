import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/src/view/screens/splash_screen.dart';
import 'package:ui/ui.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class MainRouteName {
  MainRouteName._();

  static const String root = '/';
}

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: MainRouteName.root,
    routes: <RouteBase>[
      GoRoute(
        path: MainRouteName.root,
        pageBuilder: (context, state) {
          return TransitionUtil.slideTransitionPage(state: state, child: SplashScreen());
        },
      ),
      ...AuthRouter.routes,
    ],
  );
}
