import 'package:auth/src/view/screens/forgot_password_screen.dart';
import 'package:auth/src/view/screens/login_screen.dart';
import 'package:auth/src/view/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class AuthRouteName {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
}

class AuthRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: AuthRouteName.login,
      pageBuilder: (context, state) {
        return TransitionUtil.slideTransitionPage(state: state, child: LoginScreen());
      },
    ),
    GoRoute(
      path: AuthRouteName.register,
      pageBuilder: (context, state) {
        return TransitionUtil.slideTransitionPage(state: state, child: RegisterScreen());
      },
    ),
    GoRoute(
      path: AuthRouteName.forgotPassword,
      pageBuilder: (context, state) {
        return TransitionUtil.slideTransitionPage(
          state: state,
          direction: AxisDirection.left,
          child: ForgotPasswordScreen(),
        );
      },
    ),
  ];
}
