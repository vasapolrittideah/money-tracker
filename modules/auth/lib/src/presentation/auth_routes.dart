import 'package:auth/src/models/requests/sign_in_request.dart';
import 'package:auth/src/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:auth/src/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:auth/src/presentation/pages/sign_in_page.dart';
import 'package:auth/src/presentation/pages/sign_up_page.dart';
import 'package:core/core.dart';

class AuthRouteName {
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
}

final List<GoRoute> authRoutes = [
  GoRoute(
    path: AuthRouteName.signIn,
    pageBuilder: (context, state) {
      final signInRequest = state.extra as SignInRequest?;

      return TransitionUtil.slideTransitionPage(
        state: state,
        child: BlocProvider<SignInCubit>(
          create: (context) => sl(),
          child: SignInPage(
            initialEmailValue: signInRequest?.email ?? '',
            initialPasswordValue: signInRequest?.password ?? '',
          ),
        ),
      );
    },
  ),
  GoRoute(
    path: AuthRouteName.signUp,
    pageBuilder: (context, state) {
      return TransitionUtil.slideTransitionPage(
        state: state,
        child: BlocProvider<SignUpCubit>(
          create: (context) => sl(),
          child: const SignUpPage(),
        ),
      );
    },
  ),
];
