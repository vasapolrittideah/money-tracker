import 'package:auth/gen/l10n.dart';
import 'package:auth/src/logic/cubits/login/login_cubit.dart';
import 'package:auth/src/view/auth_router.dart';
import 'package:auth/src/view/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key, this.initialEmailValue = '', this.initialPasswordValue = ''});

  final String initialEmailValue;
  final String initialPasswordValue;

  @override
  Widget build(BuildContext context) {
    void handleRegisterLinkTap() {
      context.go(AuthRouteName.register);
    }

    return BlocProvider<LoginCubit>(
      create: (_) => sl(),
      child: BlocListener<LoginCubit, LoginState>(
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
                      AuthLocalizations.of(context).screenLoginTitle,
                      style: context.appTypography.bold.text28.copyWith(color: context.appColors.textStrong950),
                    ),
                    Text(
                      AuthLocalizations.of(context).screenLoginSubtitle,
                      style: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSub600),
                    ),
                    SizedBox(height: context.appSpacing.md),
                    LoginForm(
                      key: const Key('login_form'),
                      initialEmailValue: initialEmailValue,
                      initialPasswordValue: initialPasswordValue,
                    ),
                    AppButton(
                      text: AuthLocalizations.of(context).screenLoginRegisterLink,
                      fullWidth: true,
                      mode: AppButtonMode.ghost,
                      onTap: handleRegisterLinkTap,
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
