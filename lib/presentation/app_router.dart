import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/presentation/pages/home_page.dart';
import 'package:money_tracker/presentation/pages/splash_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root_navigator',
);

class MainRouteName {
  static const root = '/';
  static const home = '/home';
}

final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: MainRouteName.root,
    redirect: _redirectWhenUnauthenticated,
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
      GoRoute(
        path: MainRouteName.home,
        pageBuilder: (context, state) {
          return TransitionUtil.slideTransitionPage(
            child: const HomePage(),
            state: state,
          );
        },
      ),
      ...authRoutes,
    ],
  );

  static FutureOr<String?> _redirectWhenUnauthenticated(
    BuildContext context,
    GoRouterState state,
  ) {
    final status = context.read<AuthCubit>().state.status;

    final currentLocation = state.matchedLocation;

    final isOnReservedLocation = _reservedLocations.contains(currentLocation);
    final isUnauthenticated = status == AuthStatus.unauthenticated;
    final isAuthenticated = status == AuthStatus.authenticated;

    if (isUnauthenticated && !isOnReservedLocation) {
      return AuthRouteName.signIn;
    }

    if (isAuthenticated && isOnReservedLocation) {
      return MainRouteName.home;
    }

    return null;
  }

  static const Set<String> _reservedLocations = {
    AuthRouteName.signIn,
    AuthRouteName.signUp,
  };
}
