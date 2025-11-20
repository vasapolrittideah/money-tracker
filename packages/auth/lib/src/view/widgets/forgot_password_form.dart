import 'package:auth/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:shared/libs.dart';
import 'package:ui/ui.dart';

class ForgotPasswordForm extends HookWidget {
  const ForgotPasswordForm({super.key});

  static const _emailFieldName = 'email';

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final emailFocusNode = useFocusNode();

    Future<void> handleFormSubmission() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final formData = formKey.currentState!.value;
        final email = formData[_emailFieldName] as String;
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
            labelText: AuthLocaleKeys.forgotPassword_emailLabel.tr(),
            hintText: AuthLocaleKeys.forgotPassword_emailHint.tr(),
            focusNode: emailFocusNode,
            textInputAction: TextInputAction.next,
            validators: [
              FormBuilderValidators.required(errorText: AuthLocaleKeys.forgotPassword_emailErrorRequired.tr()),
              FormBuilderValidators.email(errorText: AuthLocaleKeys.forgotPassword_emailErrorInvalid.tr()),
            ],
          ),
          SizedBox(height: context.appSpacing.x2s),

          // Submit Button
          AppButton(
            text: AuthLocaleKeys.forgotPassword_submitButton.tr(),
            fullWidth: true,
            onTap: handleFormSubmission,
          ),
        ],
      ),
    );
  }
}
