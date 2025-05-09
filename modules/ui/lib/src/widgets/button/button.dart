import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/src/theme/theme.dart';

enum AppButtonVariant { primary, neutral, error }

enum AppButtonMode { filled, stroke, ghost }

enum AppButtonSize { xs, sm, md }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.isBlock = false,
    this.isDisabled = false,
    this.borderWidth,
    this.size = AppButtonSize.md,
    this.variant = AppButtonVariant.primary,
    this.mode = AppButtonMode.filled,
    this.onTap,
  });

  final String text;
  final bool isBlock;
  final bool isDisabled;
  final double? borderWidth;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final AppButtonMode mode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isDisabled ? (onTap ?? () {}) : null,
      child:
          isBlock
              ? _buildContainer(context)
              : IntrinsicWidth(child: _buildContainer(context)),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final double effectiveHeight = switch (size) {
      AppButtonSize.xs => context.appSpacing.xs,
      AppButtonSize.sm => context.appSpacing.sm,
      AppButtonSize.md => context.appSpacing.md,
    };

    final double effectiveBorderWidth =
        borderWidth ?? context.appBorders.defaultWidth;

    final List<BoxShadow> effectiveShadow = switch (mode) {
      AppButtonMode.filled => const [],
      AppButtonMode.stroke => context.appShadows.xs,
      AppButtonMode.ghost => const [],
    };

    final Color effectiveBorderColor =
        !isDisabled
            ? switch (mode) {
              AppButtonMode.filled => Colors.transparent,
              AppButtonMode.stroke => switch (variant) {
                AppButtonVariant.primary => context.appColors.primaryBase,
                AppButtonVariant.neutral => context.appColors.strokeSub300,
                AppButtonVariant.error => context.appColors.errorBase,
              },
              AppButtonMode.ghost => Colors.transparent,
            }
            : context.appColors.strokeSub300;

    final Color effectiveTextColor =
        !isDisabled
            ? switch (mode) {
              AppButtonMode.filled => context.appColors.textWhite0,
              AppButtonMode.stroke => switch (variant) {
                AppButtonVariant.primary => context.appColors.primaryBase,
                AppButtonVariant.neutral => context.appColors.textSub600,
                AppButtonVariant.error => context.appColors.errorBase,
              },
              AppButtonMode.ghost => context.appColors.textSub600,
            }
            : context.appColors.textDisabled300;

    final Color effectiveBackgroundColor =
        !isDisabled
            ? switch (mode) {
              AppButtonMode.filled => switch (variant) {
                AppButtonVariant.primary => context.appColors.primaryBase,
                AppButtonVariant.neutral => context.appColors.bgStrong950,
                AppButtonVariant.error => context.appColors.errorBase,
              },
              AppButtonMode.stroke => context.appColors.bgWhite0,
              AppButtonMode.ghost => Colors.transparent,
            }
            : context.appColors.bgSub300;

    return Container(
      height: effectiveHeight,
      padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x2s),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        boxShadow: effectiveShadow,
        borderRadius: BorderRadius.circular(context.appBorders.radiusMd),
        border: Border.all(
          color: effectiveBorderColor,
          width: effectiveBorderWidth,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: context.appTypography.regular.textDefault.copyWith(
            decoration: TextDecoration.none,
            color: effectiveTextColor,
            height: 1.h,
          ),
        ),
      ),
    );
  }
}
