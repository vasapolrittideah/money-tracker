import 'package:auth/gen/l10n.dart';
import 'package:auth/src/view/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ui/ui.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key, this.initialUsernameValue = '', this.initialPasswordValue = ''});

  final String initialUsernameValue;
  final String initialPasswordValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  initialUsernameValue: initialUsernameValue,
                  initialPasswordValue: initialPasswordValue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
