import 'package:auth/generated/locale_keys.g.dart';
import 'package:auth/src/logic/cubits/register/register_cubit.dart';
import 'package:auth/src/view/auth_router.dart';
import 'package:auth/src/view/widgets/language_button.dart';
import 'package:auth/src/view/widgets/register_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key, this.initialEmailValue = '', this.initialPasswordValue = ''});

  final String initialEmailValue;
  final String initialPasswordValue;

  @override
  Widget build(BuildContext context) {
    void handleLoginLinkTap() {
      context.go(AuthRouteName.login);
    }

    return BlocProvider<RegisterCubit>(
      create: (_) => sl(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.isLoading) {
            AppLoadingOverlay.start(context);
          } else {
            AppLoadingOverlay.stop(context);
          }

          if (state.failure != null) {
            AppSnackBar.show(context, type: AppSnackBarType.failure, message: state.failure!.message);
          }
        },
        child: Scaffold(
          backgroundColor: context.appColors.staticWhite,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.appSpacing.xs),
                child: Column(
                  children: [
                    SizedBox(height: context.appSpacing.x6s),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(UiAssets.images.brand, width: 24.w, height: 24.h),
                        const LanguageButton(),
                      ],
                    ),
                    SizedBox(height: context.appSpacing.xs),
                    Text(
                      AuthLocaleKeys.register_title.tr(),
                      style: context.appTypography.bold.text28.copyWith(color: context.appColors.textStrong950),
                    ),
                    Text(
                      AuthLocaleKeys.register_subtitle.tr(),
                      style: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSub600),
                    ),
                    SizedBox(height: context.appSpacing.md),

                    // Social Buttons
                    // const AppSocialButton(provider: AppSocialButtonProvider.apple),
                    // SizedBox(height: context.appSpacing.x3s),
                    const AppSocialButton(provider: AppSocialButtonProvider.facebook),
                    SizedBox(height: context.appSpacing.x3s),
                    const AppSocialButton(provider: AppSocialButtonProvider.google),

                    AppDivider(
                      padding: EdgeInsets.symmetric(vertical: context.appSpacing.xs),
                      text: AuthLocaleKeys.register_orDivider.tr(),
                    ),

                    RegisterForm(
                      key: const Key('register_form'),
                      initialEmailValue: initialEmailValue,
                      initialPasswordValue: initialPasswordValue,
                    ),
                    AppButton(
                      text: AuthLocaleKeys.register_loginLink.tr(),
                      fullWidth: true,
                      mode: AppButtonMode.ghost,
                      onTap: handleLoginLinkTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
