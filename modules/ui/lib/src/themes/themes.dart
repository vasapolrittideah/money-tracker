import 'package:ui/src/themes/tokens/borders.dart';
import 'package:ui/src/themes/tokens/colors.dart';
import 'package:ui/src/themes/tokens/shadows.dart';
import 'package:ui/src/themes/tokens/spacing.dart';
import 'package:ui/src/themes/tokens/tokens.dart';
import 'package:ui/src/themes/tokens/typography/typography.dart';
import 'package:flutter/material.dart';

final class AppThemes extends ThemeExtension<AppThemes> {
  AppThemes({required this.tokens});

  final AppTokens tokens;

  @override
  AppThemes copyWith({AppTokens? tokens}) {
    return AppThemes(tokens: tokens ?? this.tokens);
  }

  @override
  AppThemes lerp(ThemeExtension<AppThemes>? other, double t) {
    if (other is! AppThemes) {
      return this;
    }
    return AppThemes(tokens: tokens.lerp(other.tokens, t));
  }
}

extension AppThemeExtension on BuildContext {
  AppThemes get _theme => Theme.of(this).extension<AppThemes>()!;
  AppColors get appColors => _theme.tokens.colors;
  AppTypography get appTypography => _theme.tokens.typography;
  AppBorders get appBorders => _theme.tokens.borders;
  AppShadows get appShadows => _theme.tokens.shadows;
  AppSpacing get appSpacing => _theme.tokens.spacing;
}
