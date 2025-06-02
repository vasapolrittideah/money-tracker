import 'package:auth/auth.dart';
import 'package:auth/src/presentation/pages/sign_in_page.dart';
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
                  GoogleSignInButton(),
                  SizedBox(height: context.appSpacing.x2s),
                  FacebookSignInButton(),
                  SizedBox(height: context.appSpacing.x2s),
                  AppleSignInButton(),
                  SizedBox(height: context.appSpacing.xs),
                  SocialSignInDivider(),
                  SizedBox(height: context.appSpacing.xs),
                  _FullNameInput(
                    selfFocusNode: fullNameFocusNode,
                    nextFocusNode: emailFocusNode,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _EmailInput(
                    selfFocusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _PasswordInput(selfFocusNode: passwordFocusNode),
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
  const _FullNameInput({
    required this.selfFocusNode,
    required this.nextFocusNode,
  });

  final FocusNode selfFocusNode;
  final FocusNode nextFocusNode;

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
            FormBuilderValidators.required(
              errorText: 'จำเป็นต้องกรอกชื่อ-นามสกุล',
            ),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกชื่อ-นามสกุล',
              labelText: 'ชื่อ-นามสกุล',
              errorText: field.errorText,
              focusNode: selfFocusNode,
              controller: controller,
              textInputAction: TextInputAction.next,
              onChanged: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) {
                final field = _formKey.currentState?.fields[_emailFieldName];
                final valid = field?.validate();
                if (valid != null && valid) {
                  nextFocusNode.requestFocus();
                } else {
                  selfFocusNode.requestFocus();
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
  const _EmailInput({required this.selfFocusNode, required this.nextFocusNode});

  final FocusNode selfFocusNode;
  final FocusNode nextFocusNode;

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
            FormBuilderValidators.required(errorText: 'จำเป็นต้องกรอกอีเมล'),
            FormBuilderValidators.email(errorText: 'อีเมลไม่ถูกต้อง'),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกอีเมล',
              labelText: 'อีเมล',
              errorText: field.errorText,
              focusNode: selfFocusNode,
              controller: controller,
              textInputAction: TextInputAction.next,
              onChanged: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) {
                final field = _formKey.currentState?.fields[_emailFieldName];
                final valid = field?.validate();
                if (valid != null && valid) {
                  selfFocusNode.requestFocus();
                } else {
                  nextFocusNode.requestFocus();
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
  const _PasswordInput({required this.selfFocusNode});

  final FocusNode selfFocusNode;

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
            FormBuilderValidators.required(errorText: 'จำเป็นต้องกรอกรหัสผ่าน'),
            FormBuilderValidators.minLength(
              6,
              errorText: 'รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัว',
            ),
            FormBuilderValidators.match(
              RegExp(
                r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*(),.?":{}|<>]+$',
              ),
              errorText: 'รหัสผ่านต้องมีทั้งตัวอักษรและตัวเลข',
            ),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกรหัสผ่าน',
              labelText: 'รหัสผ่าน',
              errorText: field.errorText,
              focusNode: selfFocusNode,
              controller: controller,
              textObscure: true,
              onChanged: field.didChange,
              scrollPadding: EdgeInsets.only(bottom: keyboardHeight),
              onSubmitted: (_) async {
                final field = _formKey.currentState?.fields[_passwordFieldName];
                final valid = field?.validate();
                if (valid == null || !valid) {
                  selfFocusNode.requestFocus();
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
