import 'package:auth/src/view/screens/login_screen.dart';
import 'package:auth/src/view/screens/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class AuthRouteName {
  static const login = '/login';
  static const register = '/register';
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
  ];
}
