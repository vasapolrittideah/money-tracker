import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/presentation/pages/splash_page.dart';

class MainRouteName {
  static const root = '/';
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root_navigator',
);

final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: MainRouteName.root,
    routes: [
      GoRoute(
        path: MainRouteName.root,
        pageBuilder: (context, state) {
          return TransitionUtil.slideTransitionPage(
            child: const SplashPage(),
            state: state,
          );
        },
      ),
      ...authRoutes,
    ],
  );
}
