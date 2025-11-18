import 'package:ui/generated/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    required this.text32,
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
  final TextStyle text32;

  static const _regular = FontWeight.w400;
  static const _regularVariant = [FontVariation('wght', 400)];
  static const _medium = FontWeight.w500;
  static const _mediumVariant = [FontVariation('wght', 500)];
  static const _semiBold = FontWeight.w600;
  static const _semiBoldVariant = [FontVariation('wght', 600)];
  static const _bold = FontWeight.w700;
  static const _boldVariant = [FontVariation('wght', 700)];
  static const _fontFamily = FontFamily.ibmPlexSansThai;

  static regular(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text32: TextStyle(
      fontSize: 32.sp,
      fontWeight: _regular,
      fontVariations: _regularVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
  );

  static medium(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text32: TextStyle(
      fontSize: 32.sp,
      fontWeight: _medium,
      fontVariations: _mediumVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
  );

  static semiBold(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text32: TextStyle(
      fontSize: 32.sp,
      fontWeight: _semiBold,
      fontVariations: _semiBoldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
  );

  static bold(Color defaultColor) => AppTextStyles(
    textDefault: TextStyle(
      fontSize: 14.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text8: TextStyle(
      fontSize: 8.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text10: TextStyle(
      fontSize: 10.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text12: TextStyle(
      fontSize: 12.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text16: TextStyle(
      fontSize: 16.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text18: TextStyle(
      fontSize: 18.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text20: TextStyle(
      fontSize: 20.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text24: TextStyle(
      fontSize: 24.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text28: TextStyle(
      fontSize: 28.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
      color: defaultColor,
    ),
    text32: TextStyle(
      fontSize: 32.sp,
      fontWeight: _bold,
      fontVariations: _boldVariant,
      fontFamily: _fontFamily,
      letterSpacing: 0,
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
    TextStyle? text32,
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
      text32: text32 ?? this.text32,
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
      text32: TextStyle.lerp(text32, other.text32, t)!,
    );
  }
}
