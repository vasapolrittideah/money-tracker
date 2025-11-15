import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui/gen/assets.gen.dart';
import 'package:ui/gen/l10n.dart';
import 'package:ui/src/themes/themes.dart';
import 'package:ui/src/widgets/buttons/button.dart';

enum AppSocialButtonProvider { apple, facebook, google }

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({super.key, required this.provider, this.onTap});

  final AppSocialButtonProvider provider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return switch (provider) {
      AppSocialButtonProvider.apple => AppButton(
        text: UILocalizations.of(context).socialButtonApple,
        prefix: SvgPicture.asset(
          Assets.images.apple,
          semanticsLabel: 'Apple',
          colorFilter: ColorFilter.mode(context.appColors.staticWhite, BlendMode.srcIn),
        ),
        fullWidth: true,
        variant: AppButtonVariant.neutral,
        mode: AppButtonMode.filled,
        onTap: onTap,
      ),
      AppSocialButtonProvider.facebook => AppButton(
        text: UILocalizations.of(context).socialButtonFacebook,
        prefix: SvgPicture.asset(
          Assets.images.facebook,
          semanticsLabel: 'Facebook',
          colorFilter: ColorFilter.mode(context.appColors.staticWhite, BlendMode.srcIn),
        ),
        fullWidth: true,
        backgroundColor: const Color(0xFF1877F2), // Facebook brand color
        mode: AppButtonMode.filled,
        onTap: onTap,
      ),
      AppSocialButtonProvider.google => AppButton(
        text: UILocalizations.of(context).socialButtonGoogle,
        prefix: SvgPicture.asset(Assets.images.google, semanticsLabel: 'Google'),
        fullWidth: true,
        variant: AppButtonVariant.neutral,
        mode: AppButtonMode.stroke,
        onTap: onTap,
      ),
    };
  }
}
