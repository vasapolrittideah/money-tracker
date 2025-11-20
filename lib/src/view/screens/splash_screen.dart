import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:settings/settings.dart';
import 'package:shared/libs.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasNavigated = useRef(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await context.read<LocaleCubit>().loadLocale();
      });

      return null;
    }, []);

    // Navigate to the appropriate screen after a delay when the application opens.
    Future<void> navigateWithDelay(String routeName) async {
      if (!hasNavigated.value) {
        hasNavigated.value = true;
        await Future.delayed(const Duration(seconds: 2));
      }
      if (context.mounted) {
        context.push(routeName);
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            switch (state.status) {
              case AuthStatus.authenticated:
                // TODO: Navigate to the main application screen.
                break;
              case AuthStatus.unauthenticated:
                await navigateWithDelay(AuthRouteName.login);
                break;
              case AuthStatus.unknown:
                break;
            }
          },
        ),
        BlocListener<LocaleCubit, LocaleState>(
          listener: (context, state) {
            if (state.failure != null) {
              AppSnackBar.show(
                context,
                type: AppSnackBarType.failure,
                title: state.failure!.errorCode,
                message: state.failure!.message,
              );
            }

            // Ensure locale is loaded before proceeding with authentication status check.
            if (state.locale != null) {
              context.setLocale(state.locale!.toLocale());
              context.read<AuthBloc>().add(AuthEvent.subscriptionRequested());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.appColors.staticWhite,
        body: SafeArea(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(UiAssets.images.brand, width: 65.w, height: 65.h),
                Positioned(top: 100.h, child: AppCircularProgress()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
