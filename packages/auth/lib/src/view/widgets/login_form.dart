import 'package:auth/generated/locale_keys.g.dart';
import 'package:auth/src/logic/cubits/login/login_cubit.dart';
import 'package:auth/src/view/auth_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key, this.initialEmailValue = '', this.initialPasswordValue = ''});

  final String initialEmailValue;
  final String initialPasswordValue;

  static const _emailFieldName = 'email';
  static const _passwordFieldName = 'password';

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    void handleEmailSubmitted() {
      final formField = formKey.currentState?.fields[_emailFieldName];
      if (formField?.validate() ?? false) {
        passwordFocusNode.requestFocus();
      } else {
        emailFocusNode.requestFocus();
      }
    }

    void handlePasswordSubmitted() {
      final formField = formKey.currentState?.fields[_passwordFieldName];
      if (formField?.validate() ?? false) {
        passwordFocusNode.unfocus();
      } else {
        passwordFocusNode.requestFocus();
      }
    }

    Future<void> handleFormSubmission() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final formData = formKey.currentState!.value;
        final email = formData[_emailFieldName] as String;
        final password = formData[_passwordFieldName] as String;

        context.read<LoginCubit>().login(email, password);
      }
    }

    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          AppTextField(
            fieldName: _emailFieldName,
            fieldKey: const Key(_emailFieldName),
            labelText: AuthLocaleKeys.login_emailLabel.tr(),
            hintText: AuthLocaleKeys.login_emailHint.tr(),
            focusNode: emailFocusNode,
            initialValue: initialEmailValue,
            textInputAction: TextInputAction.next,
            validators: [
              FormBuilderValidators.required(errorText: AuthLocaleKeys.login_emailErrorRequired.tr()),
              FormBuilderValidators.email(errorText: AuthLocaleKeys.login_emailErrorInvalid.tr()),
            ],
            onSubmitted: (_) => handleEmailSubmitted(),
          ),
          SizedBox(height: context.appSpacing.x2s),

          // Password Field
          AppTextField(
            fieldName: _passwordFieldName,
            fieldKey: const Key(_passwordFieldName),
            labelText: AuthLocaleKeys.login_passwordLabel.tr(),
            hintText: AuthLocaleKeys.login_passwordHint.tr(),
            focusNode: passwordFocusNode,
            textObscure: true,
            initialValue: initialPasswordValue,
            textInputAction: TextInputAction.done,
            validators: [FormBuilderValidators.required(errorText: AuthLocaleKeys.login_passwordErrorRequired.tr())],
            onSubmitted: (_) => handlePasswordSubmitted(),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              text: AuthLocaleKeys.login_forgotPasswordLink.tr(),
              mode: AppButtonMode.ghost,
              padding: EdgeInsets.zero,
              onTap: () => context.push(AuthRouteName.forgotPassword),
            ),
          ),

          // Submit Button
          AppButton(text: AuthLocaleKeys.login_submitButton.tr(), fullWidth: true, onTap: handleFormSubmission),
        ],
      ),
    );
  }
}
