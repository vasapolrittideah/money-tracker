import 'package:auth/generated/locale_keys.g.dart';
import 'package:auth/src/logic/cubits/login/login_cubit.dart';
import 'package:auth/src/logic/cubits/oauth/oauth_cubit.dart';
import 'package:auth/src/view/auth_router.dart';
import 'package:auth/src/view/widgets/language_button.dart';
import 'package:auth/src/view/widgets/login_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key, this.initialEmailValue = '', this.initialPasswordValue = ''});

  final String initialEmailValue;
  final String initialPasswordValue;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => sl()),
        BlocProvider<OAuthCubit>(create: (_) => sl()),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.isLoading) {
                    AppLoadingOverlay.start(context);
                  } else {
                    AppLoadingOverlay.stop(context);
                  }

                  if (state.failure != null) {
                    AppSnackBar.show(
                      context,
                      type: AppSnackBarType.failure,
                      title: state.failure!.errorCode,
                      message: state.failure!.message,
                    );
                  }
                },
              ),
              BlocListener<OAuthCubit, OAuthState>(
                listener: (context, state) {
                  if (state.isLoading) {
                    AppLoadingOverlay.start(context);
                  } else {
                    AppLoadingOverlay.stop(context);
                  }

                  if (state.failure != null) {
                    AppSnackBar.show(
                      context,
                      type: AppSnackBarType.failure,
                      title: state.failure!.errorCode,
                      message: state.failure!.message,
                    );
                  }
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: context.appColors.staticWhite,
              resizeToAvoidBottomInset: false,
              appBar: AppHeader(
                leading: SvgPicture.asset(UiAssets.images.brand, width: 24.w, height: 24.h),
                action: const LanguageButton(),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.appSpacing.xs),
                    child: Column(
                      children: [
                        SizedBox(height: context.appSpacing.sm),
                        Text(
                          AuthLocaleKeys.login_title.tr(),
                          style: context.appTypography.bold.text28.copyWith(color: context.appColors.textStrong950),
                        ),
                        Text(
                          AuthLocaleKeys.login_subtitle.tr(),
                          style: context.appTypography.regular.textDefault.copyWith(
                            color: context.appColors.textSub600,
                          ),
                        ),
                        SizedBox(height: context.appSpacing.sm),

                        // Social Buttons
                        // const AppSocialButton(provider: AppSocialButtonProvider.apple),
                        // SizedBox(height: context.appSpacing.x3s),
                        AppSocialButton(
                          provider: AppSocialButtonProvider.facebook,
                          onTap: () => context.read<OAuthCubit>().signInWithFacebook(),
                        ),
                        SizedBox(height: context.appSpacing.x3s),
                        AppSocialButton(
                          provider: AppSocialButtonProvider.google,
                          onTap: () => context.read<OAuthCubit>().signInWithGoogle(),
                        ),

                        AppDivider(
                          padding: EdgeInsets.symmetric(vertical: context.appSpacing.xs),
                          text: AuthLocaleKeys.login_orDivider.tr(),
                        ),

                        LoginForm(
                          key: const Key('login_form'),
                          initialEmailValue: initialEmailValue,
                          initialPasswordValue: initialPasswordValue,
                        ),
                        AppButton(
                          text: AuthLocaleKeys.login_registerLink.tr(),
                          fullWidth: true,
                          mode: AppButtonMode.ghost,
                          onTap: () => context.go(AuthRouteName.register),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
