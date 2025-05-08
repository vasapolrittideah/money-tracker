import 'package:flutter/material.dart';
import 'package:ui/src/themes/tokens/borders.dart';
import 'package:ui/src/themes/tokens/colors.dart';
import 'package:ui/src/themes/tokens/shadows.dart';
import 'package:ui/src/themes/tokens/spacing.dart';
import 'package:ui/src/themes/tokens/tokens.dart';
import 'package:ui/src/themes/tokens/typeography.dart';

final class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({required this.tokens});

  final AppTokens tokens;

  @override
  AppTheme copyWith({AppTokens? tokens}) {
    return AppTheme(tokens: tokens ?? this.tokens);
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(tokens: tokens);
  }
}

extension AppThemeX on BuildContext {
  AppTheme get _appTheme => Theme.of(this).extension<AppTheme>()!;
  AppColors get appColors => _appTheme.tokens.colors;
  AppTypography get appTypography => _appTheme.tokens.typography;
  AppBorders get appBorders => _appTheme.tokens.borders;
  AppShadows get appShadows => _appTheme.tokens.shadows;
  AppSpacing get appSpacing => _appTheme.tokens.spacing;
}
