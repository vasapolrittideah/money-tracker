import 'package:shared/src/themes/tokens/borders.dart';
import 'package:shared/src/themes/tokens/colors.dart';
import 'package:shared/src/themes/tokens/shadows.dart';
import 'package:shared/src/themes/tokens/spacing.dart';
import 'package:shared/src/themes/tokens/typography/typography.dart';
import 'package:flutter/material.dart';

final class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.colors,
    required this.typography,
    required this.borders,
    required this.shadows,
    required this.spacing,
  });

  final AppColors colors;
  final AppTypography typography;
  final AppBorders borders;
  final AppShadows shadows;
  final AppSpacing spacing;

  static final light = AppTokens(
    colors: AppColors.light,
    typography: AppTypography.light,
    borders: AppBorders.borders,
    shadows: AppShadows.light,
    spacing: AppSpacing.spacing,
  );

  @override
  AppTokens copyWith({
    AppTypography? typography,
    AppColors? colors,
    AppBorders? borders,
    AppShadows? shadows,
    AppSpacing? spacing,
  }) {
    return AppTokens(
      typography: typography ?? this.typography,
      colors: colors ?? this.colors,
      borders: borders ?? this.borders,
      shadows: shadows ?? this.shadows,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) {
      return this;
    }
    return AppTokens(
      typography: typography.lerp(other.typography, t),
      colors: colors.lerp(other.colors, t),
      borders: borders.lerp(other.borders, t),
      shadows: shadows.lerp(other.shadows, t),
      spacing: spacing.lerp(other.spacing, t),
    );
  }
}
