import 'package:flutter/material.dart';
import 'package:ui/src/themes/themes.dart';

enum AppButtonVariant { primary, neutral, error }

enum AppButtonMode { filled, stroke, ghost }

enum AppButtonSize { xs, sm, md }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.text,
    this.fullWidth = false,
    this.disabled = false,
    this.borderWidth,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.size = AppButtonSize.md,
    this.variant = AppButtonVariant.primary,
    this.mode = AppButtonMode.filled,
    this.onTap,
    this.prefix,
    this.suffix,
  });

  final String? text;
  final bool fullWidth;
  final bool disabled;
  final double? borderWidth;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final AppButtonMode mode;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? (onTap ?? () {}) : null,
      child: fullWidth ? _buildContainer(context) : IntrinsicWidth(child: _buildContainer(context)),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final double effectiveHeight = switch (size) {
      AppButtonSize.xs => context.appSpacing.sm,
      AppButtonSize.sm => context.appSpacing.md,
      AppButtonSize.md => context.appSpacing.lg,
    };

    final List<BoxShadow> effectiveShadow = switch (mode) {
      AppButtonMode.filled => const [],
      AppButtonMode.stroke => context.appShadows.xs,
      AppButtonMode.ghost => const [],
    };

    final double effectiveBorderWidth = borderWidth ?? context.appBorders.defaultBorderWidth;

    final Color effectiveBorderColor =
        borderColor ??
        (!disabled
            ? switch (mode) {
                AppButtonMode.filled => Colors.transparent,
                AppButtonMode.stroke => switch (variant) {
                  AppButtonVariant.primary => context.appColors.primaryBase,
                  AppButtonVariant.neutral => context.appColors.strokeSub300,
                  AppButtonVariant.error => context.appColors.errorBase,
                },
                AppButtonMode.ghost => Colors.transparent,
              }
            : context.appColors.strokeSub300);

    final Color effectiveTextColor =
        textColor ??
        (!disabled
            ? switch (mode) {
                AppButtonMode.filled => context.appColors.textWhite0,
                AppButtonMode.stroke => switch (variant) {
                  AppButtonVariant.primary => context.appColors.primaryBase,
                  AppButtonVariant.neutral => context.appColors.textSub600,
                  AppButtonVariant.error => context.appColors.errorBase,
                },
                AppButtonMode.ghost => context.appColors.textSub600,
              }
            : context.appColors.textDisabled300);

    final Color effectiveBackgroundColor =
        backgroundColor ??
        (!disabled
            ? switch (mode) {
                AppButtonMode.filled => switch (variant) {
                  AppButtonVariant.primary => context.appColors.primaryBase,
                  AppButtonVariant.neutral => context.appColors.bgStrong950,
                  AppButtonVariant.error => context.appColors.errorBase,
                },
                AppButtonMode.stroke => context.appColors.bgWhite0,
                AppButtonMode.ghost => Colors.transparent,
              }
            : context.appColors.bgSoft200);

    return Container(
      height: effectiveHeight,
      padding: padding ?? EdgeInsets.symmetric(horizontal: context.appSpacing.x2s),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        boxShadow: effectiveShadow,
        borderRadius: BorderRadius.circular(context.appBorders.borderRadiusMd),
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefix != null) ...[prefix!, SizedBox(width: context.appSpacing.x4s)],
          Align(
            alignment: Alignment.center,
            child: Text(
              text ?? '',
              style: context.appTypography.regular.textDefault.copyWith(
                decoration: TextDecoration.none,
                color: effectiveTextColor,
              ),
            ),
          ),
          if (suffix != null) ...[SizedBox(width: context.appSpacing.x4s), suffix!],
        ],
      ),
    );
  }
}
