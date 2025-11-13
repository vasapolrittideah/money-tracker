import 'package:auth/src/view/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class AuthRouteName {
  static const login = '/login';
}

class AuthRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: AuthRouteName.login,
      pageBuilder: (context, state) {
        return TransitionUtil.slideTransitionPage(state: state, child: LoginScreen());
      },
    ),
  ];
}
