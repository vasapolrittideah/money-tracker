import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

class AppTextInput extends HookWidget {
  const AppTextInput({
    super.key,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.initialValue,
    this.disabled = false,
    this.readOnly = false,
    this.textObscure = false,
    this.autoFocus = false,
    this.autoCorrect = true,
    this.enableSuggestion = true,
    this.maxLength,
    this.focusNode,
    this.controller,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.onChange,
    this.onSubmitted,
    this.onTap,
  });

  final String hintText;
  final String labelText;
  final String? errorText;
  final String? initialValue;
  final bool disabled;
  final bool readOnly;
  final bool textObscure;
  final bool autoFocus;
  final bool autoCorrect;
  final bool enableSuggestion;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final toggleTextObscure = useState(textObscure);
    final controller =
        this.controller ?? useTextEditingController(text: initialValue);
    final focusNode = this.focusNode ?? useFocusNode();
    final isFocused = useState(false);

    useEffect(() {
      void listener() => isFocused.value = focusNode.hasFocus;

      focusNode.addListener(listener);
      return () {
        focusNode.removeListener(listener);
        controller.dispose();
        focusNode.dispose();
      };
    }, [focusNode]);

    final error = errorText != null && errorText!.isNotEmpty;

    final effectiveBorderColor =
        error
            ? context.appColors.errorBase
            : isFocused.value
            ? context.appColors.primaryBase
            : context.appColors.strokeSub300;

    final effectiveBackgroundColor =
        disabled ? context.appColors.bgSoft200 : context.appColors.staticWhite;

    final effectiveTextColor =
        error
            ? context.appColors.errorBase
            : disabled
            ? context.appColors.textSoft400
            : context.appColors.textStrong950;

    final effectiveFloatingLabelTextColor =
        error
            ? context.appColors.errorBase
            : disabled
            ? context.appColors.textSoft400
            : context.appColors.textSub600;

    final List<BoxShadow> effectiveBoxShadow =
        isFocused.value ? [] : context.appShadows.xs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x3s),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            border: Border.all(
              color: effectiveBorderColor,
              width: context.appBorders.defaultWidth,
            ),
            borderRadius: BorderRadius.circular(context.appBorders.radiusMd),
            boxShadow: effectiveBoxShadow,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            enabled: !disabled,
            readOnly: readOnly,
            autofocus: autoFocus,
            autocorrect: autoCorrect,
            enableSuggestions: enableSuggestion,
            obscureText: toggleTextObscure.value,
            maxLength: maxLength,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: context.appTypography.regular.textDefault
                  .copyWith(color: effectiveFloatingLabelTextColor),
              labelStyle: context.appTypography.regular.textDefault.copyWith(
                color: context.appColors.textSoft400,
              ),
              hintStyle: context.appTypography.regular.textDefault.copyWith(
                color: context.appColors.textSoft400,
              ),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              suffixIcon:
                  textObscure
                      ? GestureDetector(
                        onTap: () {
                          toggleTextObscure.value = !toggleTextObscure.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: context.appSpacing.x4s,
                          ),
                          child: FaIcon(
                            toggleTextObscure.value
                                ? FontAwesomeIcons.solidEye
                                : FontAwesomeIcons.solidEyeSlash,
                            color: context.appColors.textSoft400,
                            size: context.appTypography.regular.text16.fontSize,
                          ),
                        ),
                      )
                      : null,
            ),
            cursorColor: context.appColors.primaryBase,
            style: context.appTypography.regular.textDefault.copyWith(
              color: effectiveTextColor,
              height: 1.h,
            ),
            onTapOutside: (_) => focusNode.unfocus(),
            onTap: onTap,
            onChanged: onChange,
            onSubmitted: onSubmitted,
          ),
        ),
        if (error) ...[
          SizedBox(height: context.appSpacing.x5s),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circleExclamation,
                color: context.appColors.errorBase,
                size: context.appTypography.regular.text12.fontSize,
              ),
              SizedBox(width: context.appSpacing.x5s),
              Text(
                errorText!,
                style: context.appTypography.regular.text12.copyWith(
                  decorationThickness: 0,
                  decoration: TextDecoration.none,
                  color: context.appColors.errorBase,
                  height: 1.h,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
