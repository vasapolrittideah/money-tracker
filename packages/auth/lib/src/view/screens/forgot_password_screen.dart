import 'package:auth/generated/locale_keys.g.dart';
import 'package:auth/src/view/widgets/forgot_password_form.dart';
import 'package:auth/src/view/widgets/language_button.dart';
import 'package:flutter/material.dart';
import 'package:shared/libs.dart';
import 'package:ui/ui.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      appBar: AppHeader(
        includeBackButton: true,
        titleWidget: SvgPicture.asset(UiAssets.images.brand, width: 24.w, height: 24.h),
        action: const LanguageButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appSpacing.xs),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: context.appSpacing.sm),
                  Text(
                    AuthLocaleKeys.forgotPassword_title.tr(),
                    style: context.appTypography.bold.text28.copyWith(color: context.appColors.textStrong950),
                  ),
                  Text(
                    AuthLocaleKeys.forgotPassword_subtitle.tr(),
                    style: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSub600),
                  ),
                  SizedBox(height: context.appSpacing.sm),

                  ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
