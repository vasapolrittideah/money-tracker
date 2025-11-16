import 'package:auth/gen/l10n.dart';
import 'package:auth/src/logic/cubits/register/register_cubit.dart';
import 'package:auth/src/view/auth_router.dart';
import 'package:auth/src/view/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
                padding: EdgeInsets.fromLTRB(context.appSpacing.xs, context.appSpacing.md, context.appSpacing.xs, 0),
                child: Column(
                  children: [
                    Text(
                      AuthLocalizations.of(context).screenRegisterTitle,
                      style: context.appTypography.bold.text28.copyWith(color: context.appColors.textStrong950),
                    ),
                    Text(
                      AuthLocalizations.of(context).screenRegisterSubtitle,
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
                      text: AuthLocalizations.of(context).screenRegisterOrDivider,
                    ),

                    RegisterForm(
                      key: const Key('register_form'),
                      initialEmailValue: initialEmailValue,
                      initialPasswordValue: initialPasswordValue,
                    ),
                    AppButton(
                      text: AuthLocalizations.of(context).screenRegisterLoginLink,
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
