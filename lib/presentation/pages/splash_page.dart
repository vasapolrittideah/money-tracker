import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            context.read<AuthCubit>().subscribeToAuthChanges();
          }
        });
      });
      return null;
    });

    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                Assets.images.brandLogo,
                semanticsLabel: 'Logo',
                width: context.appSpacing.md,
                height: context.appSpacing.md,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: context.appSpacing.sm),
                  child: AppSpinner(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
