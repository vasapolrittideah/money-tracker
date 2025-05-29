import 'package:auth/src/presentation/pages/sign_in_page.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';

class AuthRouteName {
  static const signIn = "/sign-in";
}

final List<GoRoute> authRoutes = [
  GoRoute(
    path: AuthRouteName.signIn,
    pageBuilder: (context, state) {
      return TransitionUtil.slideTransitionPage(
        child: const SignInPage(),
        state: state,
      );
    },
  ),
];
