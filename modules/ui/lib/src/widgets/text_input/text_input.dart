import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    this.isDisabled = false,
    this.isReadOnly = false,
    this.isTextObscure = false,
    this.isAutoFocus = false,
    this.isAutoCorrect = true,
    this.isEnableSuggestion = true,
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
  final bool isDisabled;
  final bool isReadOnly;
  final bool isTextObscure;
  final bool isAutoFocus;
  final bool isAutoCorrect;
  final bool isEnableSuggestion;
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

    final isError = errorText != null && errorText!.isNotEmpty;

    final effectiveBorderColor =
        isError
            ? context.appColors.errorBase
            : isFocused.value
            ? context.appColors.primaryBase
            : context.appColors.strokeSub300;

    final effectiveBackgroundColor =
        isDisabled
            ? context.appColors.bgSoft200
            : context.appColors.staticWhite;

    final effectiveTextColor =
        isError
            ? context.appColors.errorBase
            : isDisabled
            ? context.appColors.textSoft400
            : context.appColors.textStrong950;

    final effectiveFloatingLabelTextColor =
        isError
            ? context.appColors.errorBase
            : isDisabled
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
            enabled: !isDisabled,
            readOnly: isReadOnly,
            autofocus: isAutoFocus,
            autocorrect: isAutoCorrect,
            enableSuggestions: isEnableSuggestion,
            obscureText: isTextObscure,
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
        if (isError) ...[
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
