import 'package:auth/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ui/ui.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key, this.initialUsernameValue = '', this.initialPasswordValue = ''});

  final String initialUsernameValue;
  final String initialPasswordValue;

  static const _usernameFieldName = 'username';
  static const _passwordFieldName = 'password';

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final usernameFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    void handleUsernameSubmitted() {
      final formField = formKey.currentState?.fields[_usernameFieldName];
      if (formField?.validate() ?? false) {
        passwordFocusNode.requestFocus();
      } else {
        usernameFocusNode.requestFocus();
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
          // Username Field
          AppTextField(
            fieldName: _usernameFieldName,
            fieldKey: const Key(_usernameFieldName),
            labelText: AuthLocalizations.of(context).screenLoginUsernameLabel,
            hintText: AuthLocalizations.of(context).screenLoginUsernameHint,
            focusNode: usernameFocusNode,
            initialValue: initialUsernameValue,
            textInputAction: TextInputAction.next,
            validators: [
              FormBuilderValidators.required(errorText: AuthLocalizations.of(context).screenLoginUsernameRequiredError),
            ],
            onSubmitted: (_) => handleUsernameSubmitted(),
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
              FormBuilderValidators.required(errorText: AuthLocalizations.of(context).screenLoginPasswordRequiredError),
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
