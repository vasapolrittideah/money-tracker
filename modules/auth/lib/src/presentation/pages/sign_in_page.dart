import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

final _formKey = GlobalKey<FormBuilderState>();

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      body: SafeArea(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.images.brandLogo,
                  semanticsLabel: 'Logo',
                  width: context.appSpacing.xs,
                  height: context.appSpacing.xs,
                ),
                SizedBox(height: context.appSpacing.lg),
                _GoogleSignInButton(),
                SizedBox(height: context.appSpacing.x2s),
                _FacebookSignInButton(),
                SizedBox(height: context.appSpacing.x2s),
                _AppleSignInButton(),
                SizedBox(height: context.appSpacing.xs),
                _SocialSignInDivider(),
                SizedBox(height: context.appSpacing.xs),
                _EmailInput(),
                SizedBox(height: context.appSpacing.x2s),
                _PasswordInput(),
                SizedBox(height: context.appSpacing.x2s),
                _SubmitButton(),
                SizedBox(height: context.appSpacing.x5s),
                _ForgotPasswordButton(),
                Spacer(),
                _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleSignInButton extends HookWidget {
  const _GoogleSignInButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'เข้าสู่ระบบด้วย Google',
      fullWidth: true,
      variant: AppButtonVariant.neutral,
      mode: AppButtonMode.stroke,
      prefix: SvgPicture.asset(
        Assets.images.googleLogo,
        semanticsLabel: 'Google Logo',
      ),
    );
  }
}

class _FacebookSignInButton extends HookWidget {
  const _FacebookSignInButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'เข้าสู่ระบบด้วย Facebook',
      fullWidth: true,
      variant: AppButtonVariant.neutral,
      mode: AppButtonMode.filled,
      backgroundColor: Color(0xFF2374F2),
      prefix: SvgPicture.asset(
        Assets.images.facebookLogo,
        semanticsLabel: 'Apple Logo',
        colorFilter: ColorFilter.mode(
          context.appColors.staticWhite,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _AppleSignInButton extends HookWidget {
  const _AppleSignInButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'เข้าสู่ระบบด้วย Apple',
      fullWidth: true,
      variant: AppButtonVariant.neutral,
      mode: AppButtonMode.filled,
      prefix: SvgPicture.asset(
        Assets.images.appleLogo,
        semanticsLabel: 'Apple Logo',
        colorFilter: ColorFilter.mode(
          context.appColors.staticWhite,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _SocialSignInDivider extends StatelessWidget {
  const _SocialSignInDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.strokeSub300)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x4s),
          child: Text(
            'หรือ',
            style: context.appTypography.regular.text12.copyWith(
              color: context.appColors.textSub600,
            ),
          ),
        ),
        Expanded(child: Divider(color: context.appColors.strokeSub300)),
      ],
    );
  }
}

class _EmailInput extends HookWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField(
          name: 'email',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกอีเมล',
              labelText: 'อีเมล',
              errorText: field.errorText,
              focusNode: focusNode,
              controller: controller,
            );
          },
        ),
      ],
    );
  }
}

class _PasswordInput extends HookWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField(
          name: 'password',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
          builder: (FormFieldState<String> field) {
            return AppTextInput(
              hintText: 'กรุณากรอกรหัสผ่าน',
              labelText: 'รหัสผ่าน',
              errorText: field.errorText,
              focusNode: focusNode,
              controller: controller,
              textObscure: true,
            );
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(text: 'เข้าสู่ระบบ', fullWidth: true);
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          text: 'ลืมรหัสผ่าน',
          fullWidth: true,
          textColor: context.appColors.primaryBase,
          variant: AppButtonVariant.neutral,
          mode: AppButtonMode.ghost,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ยังไม่มีบัญชี?',
          style: context.appTypography.regular.textDefault.copyWith(
            color: context.appColors.textSoft400,
          ),
        ),
        SizedBox(width: context.appSpacing.x5s),
        AppButton(
          text: 'สมัครเลย!',
          fullWidth: true,
          textColor: context.appColors.primaryBase,
          variant: AppButtonVariant.neutral,
          mode: AppButtonMode.ghost,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
