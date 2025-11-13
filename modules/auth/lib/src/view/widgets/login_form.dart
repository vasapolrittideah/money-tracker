import 'package:auth/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
        final formData = formKey.currentState?.value;
        // TODO: Implement actual login logic here
        print('Form submitted with data: $formData');
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
            labelText: AuthLocalizations.of(context).screenLoginEmailLabel,
            hintText: AuthLocalizations.of(context).screenLoginEmailHint,
            focusNode: emailFocusNode,
            initialValue: initialEmailValue,
            textInputAction: TextInputAction.next,
            validators: [
              FormBuilderValidators.required(errorText: AuthLocalizations.of(context).screenLoginEmailErrorRequired),
              FormBuilderValidators.email(errorText: AuthLocalizations.of(context).screenLoginEmailErrorInvalid),
            ],
            onSubmitted: (_) => handleEmailSubmitted(),
          ),
          SizedBox(height: context.appSpacing.x2s),

          // Password Field
          AppTextField(
            fieldName: _passwordFieldName,
            fieldKey: const Key(_passwordFieldName),
            labelText: AuthLocalizations.of(context).screenLoginPasswordLabel,
            hintText: AuthLocalizations.of(context).screenLoginPasswordHint,
            focusNode: passwordFocusNode,
            textObscure: true,
            initialValue: initialPasswordValue,
            textInputAction: TextInputAction.done,
            validators: [
              FormBuilderValidators.required(errorText: AuthLocalizations.of(context).screenLoginPasswordErrorRequired),
            ],
            onSubmitted: (_) => handlePasswordSubmitted(),
          ),
          SizedBox(height: context.appSpacing.x2s),

          // Submit Button
          AppButton(
            text: AuthLocalizations.of(context).screenLoginSubmitButton,
            fullWidth: true,
            onTap: handleFormSubmission,
          ),
        ],
      ),
    );
  }
}
