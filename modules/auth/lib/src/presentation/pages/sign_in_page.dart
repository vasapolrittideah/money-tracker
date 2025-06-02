import 'package:auth/src/presentation/auth_routes.dart';
import 'package:auth/src/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

final _formKey = GlobalKey<FormBuilderState>();
final _emailFieldName = 'email';
final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
final _passwordFieldName = 'password';
final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

class SignInPage extends HookWidget {
  const SignInPage({
    super.key,
    this.initialEmailValue = '',
    this.initialPasswordValue = '',
  });

  final String initialEmailValue;
  final String initialPasswordValue;

  @override
  Widget build(BuildContext context) {
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final signInCubit = useBloc<SignInCubit>();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (initialEmailValue.isNotEmpty) {
          _emailFieldKey.currentState?.didChange(initialEmailValue);
        }

        if (initialPasswordValue.isNotEmpty) {
          _passwordFieldKey.currentState?.didChange(initialPasswordValue);
        }
      });

      return null;
    });

    useBlocListener(signInCubit, (cubit, state, context) async {
      switch (state) {
        case SignInLoading():
          AppDialog.startLoading(context);
          break;

        case SignInFailure(:final failure):
          AppDialog.stopLoading(context);

          final defaultMessage =
              'ไม่สามารถเข้าสู่ระบบได้ เนื่องจาก${failure.message}';
          String message = defaultMessage;

          if (failure case ServerFailure(code: final code)) {
            message = switch (code) {
              ErrorCode.notFound =>
                'ไม่พบผู้ใช้งานอีเมลนี้ ตรวจสอบอีเมลอีกครั้ง',
              ErrorCode.unauthenticated =>
                'รหัสผ่านไม่ถูกต้อง ตรวจสอบรหัสผ่านอีกครั้ง',
              _ => defaultMessage,
            };
          }

          if (context.mounted) {
            AppSnackBar.show(
              context: context,
              type: SnackBarType.failure,
              message: message,
            );
          }
          break;

        case SignInSuccess():
          AppDialog.stopLoading(context);
          break;

        case SignInInitial():
          break;
      }
    });

    final bottomInset =
        (MediaQuery.of(context).viewInsets.bottom -
                MediaQuery.of(context).padding.top)
            .abs();

    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(child: _SignUpButton()),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  _EmailInput(
                    selfFocusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                    initialValue: initialEmailValue,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _PasswordInput(
                    selfFocusNode: passwordFocusNode,
                    initialValue: initialPasswordValue,
                  ),
                  SizedBox(height: context.appSpacing.x2s),
                  _SignInSubmitButton(),
                  SizedBox(height: context.appSpacing.x5s),
                  _ForgotPasswordButton(),
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

class GoogleSignInButton extends HookWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'ดำเนินการด้วย Google',
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

class FacebookSignInButton extends HookWidget {
  const FacebookSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'ดำเนินการด้วย Facebook',
      fullWidth: true,
      variant: AppButtonVariant.neutral,
      mode: AppButtonMode.filled,
      backgroundColor: Color(0xFF2374F2),
      prefix: SvgPicture.asset(
        Assets.images.facebookLogo,
        semanticsLabel: 'Facebook Logo',
        colorFilter: ColorFilter.mode(
          context.appColors.staticWhite,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class AppleSignInButton extends HookWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'ดำเนินการด้วย Apple',
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

class SocialSignInDivider extends StatelessWidget {
  const SocialSignInDivider({super.key});

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
  const _EmailInput({
    required this.selfFocusNode,
    required this.nextFocusNode,
    this.initialValue = '',
  });

  final FocusNode selfFocusNode;
  final FocusNode nextFocusNode;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
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

class _PasswordInput extends HookWidget {
  const _PasswordInput({required this.selfFocusNode, this.initialValue = ''});

  final FocusNode selfFocusNode;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
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

class _SignInSubmitButton extends StatelessWidget {
  const _SignInSubmitButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'เข้าสู่ระบบ',
      fullWidth: true,
      onTap: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          await context.read<SignInCubit>().signIn(
            email: _emailFieldKey.currentState?.value,
            password: _passwordFieldKey.currentState?.value,
          );
        }
      },
    );
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
          onTap: () {
            context.go(AuthRouteName.signUp);
          },
        ),
      ],
    );
  }
}
