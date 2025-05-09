import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/src/generated/fonts.gen.dart';
import 'package:ui/src/theme/tokens/colors.dart';

final class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({required this.regular, required this.bold});

  final AppTextStyles regular;
  final AppTextStyles bold;

  static final light = AppTypography(
    regular: AppTextStyles.regular(AppColors.light.textStrong950),
    bold: AppTextStyles.bold(AppColors.light.textStrong950),
  );

  @override
  AppTypography copyWith({
    AppTextStyles? regular,
    AppTextStyles? medium,
    AppTextStyles? semiBold,
    AppTextStyles? bold,
  }) {
    return AppTypography(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      regular: regular.lerp(other.regular, t),
      bold: bold.lerp(other.bold, t),
    );
  }
}

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.textDefault,
    required this.text8,
    required this.text10,
    required this.text12,
    required this.text16,
    required this.text18,
    required this.text20,
    required this.text24,
    required this.text28,
  });

  final TextStyle textDefault; // text14
  final TextStyle text8;
  final TextStyle text10;
  final TextStyle text12;
  final TextStyle text16;
  final TextStyle text18;
  final TextStyle text20;
  final TextStyle text24;
  final TextStyle text28;

  static const _regular = FontWeight.w400;
  static const _regularVariant = [FontVariation('wght', 400)];
  static const _bold = FontWeight.w700;
  static const _boldVariant = [FontVariation('wght', 700)];
  static const _fontFamily = FontFamily.lINESeedSansTH;

  static regular(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
  );

  static bold(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      color: defaultColor,
    ),
  );

  @override
  AppTextStyles copyWith({
    TextStyle? textDefault,
    TextStyle? text8,
    TextStyle? text10,
    TextStyle? text12,
    TextStyle? text16,
    TextStyle? text18,
    TextStyle? text20,
    TextStyle? text24,
    TextStyle? text28,
  }) {
    return AppTextStyles(
      textDefault: textDefault ?? this.textDefault,
      text8: text8 ?? this.text8,
      text10: text10 ?? this.text10,
      text12: text12 ?? this.text12,
      text16: text16 ?? this.text16,
      text18: text18 ?? this.text18,
      text20: text20 ?? this.text20,
      text24: text24 ?? this.text24,
      text28: text28 ?? this.text28,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      textDefault: TextStyle.lerp(textDefault, other.textDefault, t)!,
      text8: TextStyle.lerp(text8, other.text8, t)!,
      text10: TextStyle.lerp(text10, other.text10, t)!,
      text12: TextStyle.lerp(text12, other.text12, t)!,
      text16: TextStyle.lerp(text16, other.text16, t)!,
      text18: TextStyle.lerp(text18, other.text18, t)!,
      text20: TextStyle.lerp(text20, other.text20, t)!,
      text24: TextStyle.lerp(text24, other.text24, t)!,
      text28: TextStyle.lerp(text28, other.text28, t)!,
    );
  }
}
