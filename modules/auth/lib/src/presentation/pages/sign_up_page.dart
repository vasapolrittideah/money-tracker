import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

final _formKey = GlobalKey<FormBuilderState>();
final _fullNameFieldName = 'full_name';
final _fullNameFieldKey = GlobalKey<FormBuilderFieldState>();
final _emailFieldName = 'email';
final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
final _passwordFieldName = 'password';
final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

class SignUpPage extends HookWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    final bottomInset =
        (MediaQuery.of(context).viewInsets.bottom -
                MediaQuery.of(context).padding.top)
            .abs();

    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(child: _SignInButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.appSpacing.xs,
              context.appSpacing.xl,
              context.appSpacing.xs,
              0,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.images.brandLogo,
                    semanticsLabel: 'Logo',
                    width: context.appSpacing.xs,
                    height: context.appSpacing.xs,
                  ),
                  SizedBox(height: context.appSpacing.lg),
                  _FullNameInput(
                    focusNode: fullNameFocusNode,
                    emailFocusNode: emailFocusNode,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _EmailInput(
                    focusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _PasswordInput(focusNode: passwordFocusNode),
                  SizedBox(height: context.appSpacing.x2s),
                  _SignUpSubmitButton(),
                  Padding(padding: EdgeInsets.only(bottom: bottomInset)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullNameInput extends HookWidget {
  const _FullNameInput({required this.focusNode, required this.emailFocusNode});

  final FocusNode focusNode;
  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField(
          name: _fullNameFieldName,
          key: _fullNameFieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'กรุณากรอกชื่อ-นามสกุล'),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกชื่อ-นามสกุล',
              labelText: 'ชื่อ-นามสกุล',
              errorText: field.errorText,
              focusNode: focusNode,
              controller: controller,
              textInputAction: TextInputAction.next,
              onChange: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) {
                final field = _formKey.currentState?.fields[_emailFieldName];
                final valid = field?.validate();
                if (valid != null && valid) {
                  emailFocusNode.requestFocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _EmailInput extends HookWidget {
  const _EmailInput({required this.focusNode, required this.passwordFocusNode});

  final FocusNode focusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField(
          name: _emailFieldName,
          key: _emailFieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'กรุณากรอกอีเมล'),
            FormBuilderValidators.email(errorText: 'กรุณากรอกอีเมลให้ถูกต้อง'),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกอีเมล',
              labelText: 'อีเมล',
              errorText: field.errorText,
              focusNode: focusNode,
              controller: controller,
              textInputAction: TextInputAction.next,
              onChange: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) {
                final field = _formKey.currentState?.fields[_emailFieldName];
                final valid = field?.validate();
                if (valid != null && valid) {
                  passwordFocusNode.requestFocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _PasswordInput extends HookWidget {
  const _PasswordInput({required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField(
          name: _passwordFieldName,
          key: _passwordFieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'กรุณากรอกรหัสผ่าน'),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกรหัสผ่าน',
              labelText: 'รหัสผ่าน',
              errorText: field.errorText,
              focusNode: focusNode,
              controller: controller,
              textObscure: true,
              onChange: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) async {
                final field = _formKey.currentState?.fields[_passwordFieldName];
                final valid = field?.validate();
                if (valid == null || !valid) {
                  focusNode.requestFocus();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _SignUpSubmitButton extends StatelessWidget {
  const _SignUpSubmitButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(text: 'สมัคร', fullWidth: true, onTap: () async {});
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'มีบัญชีอยู่แล้ว?',
          style: context.appTypography.regular.textDefault.copyWith(
            color: context.appColors.textSoft400,
          ),
        ),
        SizedBox(width: context.appSpacing.x5s),
        AppButton(
          text: 'เข้าสู่ระบบ',
          fullWidth: true,
          textColor: context.appColors.primaryBase,
          variant: AppButtonVariant.neutral,
          mode: AppButtonMode.ghost,
          padding: EdgeInsets.zero,
          onTap: () {
            context.go(AuthRouteName.signIn);
          },
        ),
      ],
    );
  }
}
