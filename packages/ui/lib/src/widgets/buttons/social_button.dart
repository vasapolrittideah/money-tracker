import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui/generated/assets.gen.dart';
import 'package:ui/generated/locale_keys.g.dart';
import 'package:ui/src/themes/themes.dart';
import 'package:ui/src/widgets/buttons/button.dart';

enum AppSocialButtonProvider {
  // apple,
  facebook,
  google,
}

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({super.key, required this.provider, this.onTap});

  final AppSocialButtonProvider provider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return switch (provider) {
      // AppSocialButtonProvider.apple => AppButton(
      //   text: UiLocaleKeys.socialButton_continueWithApple.tr(),
      //   prefix: SvgPicture.asset(
      //     Assets.images.apple,
      //     semanticsLabel: 'Apple',
      //     colorFilter: ColorFilter.mode(context.appColors.staticWhite, BlendMode.srcIn),
      //   ),
      //   fullWidth: true,
      //   variant: AppButtonVariant.neutral,
      //   mode: AppButtonMode.filled,
      //   onTap: onTap,
      // ),
      AppSocialButtonProvider.facebook => AppButton(
        text: UiLocaleKeys.socialButton_continueWithFacebook.tr(),
        prefix: SvgPicture.asset(
          UiAssets.images.facebook,
          semanticsLabel: 'Facebook',
          colorFilter: ColorFilter.mode(context.appColors.staticWhite, BlendMode.srcIn),
        ),
        fullWidth: true,
        backgroundColor: const Color(0xFF1877F2), // Facebook brand color
        mode: AppButtonMode.filled,
        onTap: onTap,
      ),
      AppSocialButtonProvider.google => AppButton(
        text: UiLocaleKeys.socialButton_continueWithGoogle.tr(),
        prefix: SvgPicture.asset(UiAssets.images.google, semanticsLabel: 'Google'),
        fullWidth: true,
        variant: AppButtonVariant.neutral,
        mode: AppButtonMode.stroke,
        onTap: onTap,
      ),
    };
  }
}
