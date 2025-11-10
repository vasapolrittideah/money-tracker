import 'package:shared/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class AppTextField extends HookWidget {
  const AppTextField({
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
    this.enableSuggestions = true,
    this.maxLength,
    this.focusNode,
    this.scrollPadding,
    this.controller,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
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
  final bool enableSuggestions;
  final int? maxLength;
  final FocusNode? focusNode;
  final EdgeInsets? scrollPadding;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? useTextEditingController(text: initialValue);
    final focusNode = this.focusNode ?? useFocusNode();
    final textObscure = useState(this.textObscure);
    final focused = useState(false);

    final hasExternalController = this.controller != null;
    final hasExternalFocusNode = this.focusNode != null;

    useEffect(() {
      void onFocusChangeListener() => focused.value = focusNode.hasFocus;

      focusNode.addListener(onFocusChangeListener);

      return () {
        if (!hasExternalController) {
          controller.dispose();
        }

        if (!hasExternalFocusNode) {
          focusNode.removeListener(onFocusChangeListener);
          focusNode.dispose();
        }
      };
    }, [focusNode]);

    final error = errorText != null && errorText!.isNotEmpty;

    final effectiveBorderColor = error
        ? context.appColors.errorBase
        : focused.value
        ? context.appColors.primaryBase
        : context.appColors.strokeSub300;

    final effectiveBackgroundColor = disabled ? context.appColors.bgSoft200 : context.appColors.staticWhite;

    final effectiveTextColor = error
        ? context.appColors.errorBase
        : disabled
        ? context.appColors.textSoft400
        : context.appColors.textStrong950;

    final effectiveFloatingLabelTextColor = error
        ? context.appColors.errorBase
        : disabled
        ? context.appColors.textSoft400
        : context.appColors.textSub600;

    final List<BoxShadow> effectiveBoxShadow = focused.value ? [] : context.appShadows.xs;

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
          child: TextField(
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
              labelStyle: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSoft400),
              hintStyle: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSoft400),
              suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
              suffixIcon: textObscure.value
                  ? GestureDetector(
                      onTap: () => textObscure.value = !textObscure.value,
                      child: Padding(
                        padding: EdgeInsets.only(left: context.appSpacing.x4s),
                        child: Icon(
                          textObscure.value ? Remix.eye_fill : Remix.eye_off_fill,
                          color: context.appColors.textSoft400,
                          size: context.appTypography.regular.text16.fontSize,
                        ),
                      ),
                    )
                  : null,
            ),
            cursorColor: context.appColors.primaryBase,
            style: context.appTypography.regular.textDefault.copyWith(color: effectiveTextColor, height: 1.h),
            onTapOutside: (_) => focusNode.unfocus(),
            onTap: onTap,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        if (error) ...[
          SizedBox(height: context.appSpacing.x5s),
          Row(
            children: [
              Icon(
                Remix.error_warning_fill,
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
