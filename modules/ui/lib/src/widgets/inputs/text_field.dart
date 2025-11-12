import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ui/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    required this.fieldName,
    required this.fieldKey,
    required this.hintText,
    required this.labelText,
    this.initialValue = '',
    this.disabled = false,
    this.readOnly = false,
    this.textObscure = false,
    this.autoFocus = false,
    this.autoCorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.focusNode,
    this.scrollPadding,
    this.controller,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.onTap,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.validators = const [],
  });

  final String fieldName;
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String initialValue;
  final bool disabled;
  final bool readOnly;
  final bool textObscure;
  final bool autoFocus;
  final bool autoCorrect;
  final bool enableSuggestions;
  final int? maxLength;
  final FocusNode? focusNode;
  final EdgeInsets? scrollPadding;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final AutovalidateMode autoValidateMode;
  final List<String? Function(String?)> validators;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? useTextEditingController(text: initialValue);
    final focusNode = this.focusNode ?? useFocusNode();
    final textObscure = useState(this.textObscure);
    final focused = useState(false);

    useEffect(() {
      void onFocusChangeListener() => focused.value = focusNode.hasFocus;

      focusNode.addListener(onFocusChangeListener);

      return () {
        controller.dispose();
        focusNode.removeListener(onFocusChangeListener);
        focusNode.dispose();
      };
    }, [focusNode]);

    final List<BoxShadow> effectiveBoxShadow = focused.value ? [] : context.appShadows.xs;

    return FormBuilderField<String>(
      name: fieldName,
      key: fieldKey,
      initialValue: initialValue,
      autovalidateMode: autoValidateMode,
      validator: FormBuilderValidators.compose(validators),
      builder: (FormFieldState<String> field) {
        final hasError = field.errorText != null && field.errorText!.isNotEmpty;

        final effectiveBorderColor = hasError
            ? context.appColors.errorBase
            : focused.value
            ? context.appColors.primaryBase
            : context.appColors.strokeSub300;

        final effectiveBackgroundColor = disabled ? context.appColors.bgSoft200 : context.appColors.staticWhite;

        final effectiveTextColor = hasError
            ? context.appColors.errorBase
            : disabled
            ? context.appColors.textSoft400
            : context.appColors.textStrong950;

        final effectiveFloatingLabelTextColor = hasError
            ? context.appColors.errorBase
            : disabled
            ? context.appColors.textSoft400
            : context.appColors.textSub600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x3s),
              decoration: BoxDecoration(
                color: effectiveBackgroundColor,
                border: Border.all(color: effectiveBorderColor, width: context.appBorders.defaultBorderWidth),
                borderRadius: BorderRadius.circular(context.appBorders.borderRadiusMd),
                boxShadow: effectiveBoxShadow,
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: !disabled,
                    readOnly: readOnly,
                    autofocus: autoFocus,
                    autocorrect: autoCorrect,
                    enableSuggestions: enableSuggestions,
                    obscureText: textObscure.value,
                    scrollPadding: scrollPadding ?? EdgeInsets.zero,
                    maxLength: maxLength,
                    textCapitalization: textCapitalization ?? TextCapitalization.none,
                    textInputAction: textInputAction,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      labelText: labelText,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: context.appTypography.regular.textDefault.copyWith(
                        color: effectiveFloatingLabelTextColor,
                      ),
                      labelStyle: context.appTypography.regular.textDefault.copyWith(
                        color: context.appColors.textSoft400,
                      ),
                      hintStyle: context.appTypography.regular.textDefault.copyWith(
                        color: context.appColors.textSoft400,
                      ),
                      suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
                      suffixIcon: null,
                    ),
                    cursorColor: context.appColors.primaryBase,
                    style: context.appTypography.regular.textDefault.copyWith(color: effectiveTextColor, height: 1.h),
                    onTapOutside: (_) => focusNode.unfocus(),
                    onTap: onTap,
                    onChanged: field.didChange,
                    onSubmitted: onSubmitted,
                  ),

                  if (this.textObscure)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => textObscure.value = !textObscure.value,
                      child: FaIcon(
                        textObscure.value ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                        color: context.appColors.textSoft400,
                        size: context.appTypography.regular.text16.fontSize,
                      ),
                    ),
                ],
              ),
            ),
            if (hasError) ...[
              SizedBox(height: context.appSpacing.x5s),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleExclamation,
                    size: context.appTypography.regular.text10.fontSize,
                    color: context.appColors.errorBase,
                  ),
                  SizedBox(width: context.appSpacing.x5s),
                  Text(
                    field.errorText!,
                    style: context.appTypography.regular.text12.copyWith(
                      decorationThickness: 0,
                      decoration: TextDecoration.none,
                      color: context.appColors.errorBase,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
