import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.staticBlack,
    required this.staticWhite,
    required this.primaryDark,
    required this.primaryDarker,
    required this.primaryBase,
    required this.primaryAlpha24,
    required this.primaryAlpha16,
    required this.primaryAlpha10,
    required this.bgStrong950,
    required this.bgSurface800,
    required this.bgSub300,
    required this.bgSoft200,
    required this.bgWeak50,
    required this.bgWhite0,
    required this.textStrong950,
    required this.textSub600,
    required this.textSoft400,
    required this.textDisabled300,
    required this.textWhite0,
    required this.strokeStrong950,
    required this.strokeSub300,
    required this.strokeSoft200,
    required this.strokeWhite0,
    required this.informationDark,
    required this.informationBase,
    required this.informationLight,
    required this.informationLighter,
    required this.warningDark,
    required this.warningBase,
    required this.warningLight,
    required this.warningLighter,
    required this.errorDark,
    required this.errorBase,
    required this.errorLight,
    required this.errorLighter,
    required this.successDark,
    required this.successBase,
    required this.successLight,
    required this.successLighter,
  });

  final Color staticBlack;
  final Color staticWhite;
  final Color primaryDark;
  final Color primaryDarker;
  final Color primaryBase;
  final Color primaryAlpha24;
  final Color primaryAlpha16;
  final Color primaryAlpha10;
  final Color bgStrong950;
  final Color bgSurface800;
  final Color bgSub300;
  final Color bgSoft200;
  final Color bgWeak50;
  final Color bgWhite0;
  final Color textStrong950;
  final Color textSub600;
  final Color textSoft400;
  final Color textDisabled300;
  final Color textWhite0;
  final Color strokeStrong950;
  final Color strokeSub300;
  final Color strokeSoft200;
  final Color strokeWhite0;
  final Color informationDark;
  final Color informationBase;
  final Color informationLight;
  final Color informationLighter;
  final Color warningDark;
  final Color warningBase;
  final Color warningLight;
  final Color warningLighter;
  final Color errorDark;
  final Color errorBase;
  final Color errorLight;
  final Color errorLighter;
  final Color successDark;
  final Color successBase;
  final Color successLight;
  final Color successLighter;

  static const _primaryDark = AppColorPalette.purple800;
  static const _primaryDarker = AppColorPalette.purple700;
  static const _primaryBase = AppColorPalette.purple500;
  static const _primaryAlpha24 = AppColorPalette.purpleAlpha24;
  static const _primaryAlpha16 = AppColorPalette.purpleAlpha16;
  static const _primaryAlpha10 = AppColorPalette.purpleAlpha10;

  static const light = AppColors(
    // Static colors
    staticBlack: AppColorPalette.neutral950,
    staticWhite: AppColorPalette.neutral0,

    // Brand colors
    primaryDark: _primaryDark,
    primaryDarker: _primaryDarker,
    primaryBase: _primaryBase,
    primaryAlpha24: _primaryAlpha24,
    primaryAlpha16: _primaryAlpha16,
    primaryAlpha10: _primaryAlpha10,

    // Background colors
    bgStrong950: AppColorPalette.neutral950,
    bgSurface800: AppColorPalette.neutral800,
    bgSub300: AppColorPalette.neutral300,
    bgSoft200: AppColorPalette.neutral200,
    bgWeak50: AppColorPalette.neutral50,
    bgWhite0: AppColorPalette.neutral0,

    // Text colors
    textStrong950: AppColorPalette.neutral950,
    textSub600: AppColorPalette.neutral600,
    textSoft400: AppColorPalette.neutral400,
    textDisabled300: AppColorPalette.neutral300,
    textWhite0: AppColorPalette.neutral0,

    // Stroke colors
    strokeStrong950: AppColorPalette.neutral950,
    strokeSub300: AppColorPalette.neutral300,
    strokeSoft200: AppColorPalette.neutral200,
    strokeWhite0: AppColorPalette.neutral0,

    // Informational colors
    informationDark: AppColorPalette.blue950,
    informationBase: AppColorPalette.blue500,
    informationLight: AppColorPalette.blue200,
    informationLighter: AppColorPalette.blue50,

    // Warning colors
    warningDark: AppColorPalette.orange950,
    warningBase: AppColorPalette.orange500,
    warningLight: AppColorPalette.orange200,
    warningLighter: AppColorPalette.orange50,

    // Error colors
    errorDark: AppColorPalette.red950,
    errorBase: AppColorPalette.red500,
    errorLight: AppColorPalette.red200,
    errorLighter: AppColorPalette.red50,

    // Success colors
    successDark: AppColorPalette.green950,
    successBase: AppColorPalette.green500,
    successLight: AppColorPalette.green200,
    successLighter: AppColorPalette.green50,
  );

  @override
  AppColors copyWith({
    Color? staticBlack,
    Color? staticWhite,
    Color? primaryDark,
    Color? primaryDarker,
    Color? primaryBase,
    Color? primaryAlpha24,
    Color? primaryAlpha16,
    Color? primaryAlpha10,
    Color? bgStrong950,
    Color? bgSurface800,
    Color? bgSub300,
    Color? bgSoft200,
    Color? bgWeak50,
    Color? bgWhite0,
    Color? textStrong950,
    Color? textSub600,
    Color? textSoft400,
    Color? textDisabled300,
    Color? textWhite0,
    Color? strokeStrong950,
    Color? strokeSub300,
    Color? strokeSoft200,
    Color? strokeWhite0,
    Color? informationDark,
    Color? informationBase,
    Color? informationLight,
    Color? informationLighter,
    Color? warningDark,
    Color? warningBase,
    Color? warningLight,
    Color? warningLighter,
    Color? errorDark,
    Color? errorBase,
    Color? errorLight,
    Color? errorLighter,
    Color? successDark,
    Color? successBase,
    Color? successLight,
    Color? successLighter,
  }) {
    return AppColors(
      staticBlack: staticBlack ?? this.staticBlack,
      staticWhite: staticWhite ?? this.staticWhite,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryDarker: primaryDarker ?? this.primaryDarker,
      primaryBase: primaryBase ?? this.primaryBase,
      primaryAlpha24: primaryAlpha24 ?? this.primaryAlpha24,
      primaryAlpha16: primaryAlpha16 ?? this.primaryAlpha16,
      primaryAlpha10: primaryAlpha10 ?? this.primaryAlpha10,
      bgStrong950: bgStrong950 ?? this.bgStrong950,
      bgSurface800: bgSurface800 ?? this.bgSurface800,
      bgSub300: bgSub300 ?? this.bgSub300,
      bgSoft200: bgSoft200 ?? this.bgSoft200,
      bgWeak50: bgWeak50 ?? this.bgWeak50,
      bgWhite0: bgWhite0 ?? this.bgWhite0,
      textStrong950: textStrong950 ?? this.textStrong950,
      textSub600: textSub600 ?? this.textSub600,
      textSoft400: textSoft400 ?? this.textSoft400,
      textDisabled300: textDisabled300 ?? this.textDisabled300,
      textWhite0: textWhite0 ?? this.textWhite0,
      strokeStrong950: strokeStrong950 ?? this.strokeStrong950,
      strokeSub300: strokeSub300 ?? this.strokeSub300,
      strokeSoft200: strokeSoft200 ?? this.strokeSoft200,
      strokeWhite0: strokeWhite0 ?? this.strokeWhite0,
      informationDark: informationDark ?? this.informationDark,
      informationBase: informationBase ?? this.informationBase,
      informationLight: informationLight ?? this.informationLight,
      informationLighter: informationLighter ?? this.informationLighter,
      warningDark: warningDark ?? this.warningDark,
      warningBase: warningBase ?? this.warningBase,
      warningLight: warningLight ?? this.warningLight,
      warningLighter: warningLighter ?? this.warningLighter,
      errorDark: errorDark ?? this.errorDark,
      errorBase: errorBase ?? this.errorBase,
      errorLight: errorLight ?? this.errorLight,
      errorLighter: errorLighter ?? this.errorLighter,
      successDark: successDark ?? this.successDark,
      successBase: successBase ?? this.successBase,
      successLight: successLight ?? this.successLight,
      successLighter: successLighter ?? this.successLighter,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      staticBlack: Color.lerp(staticBlack, other.staticBlack, t)!,
      staticWhite: Color.lerp(staticWhite, other.staticWhite, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryDarker: Color.lerp(primaryDarker, other.primaryDarker, t)!,
      primaryBase: Color.lerp(primaryBase, other.primaryBase, t)!,
      primaryAlpha24: Color.lerp(primaryAlpha24, other.primaryAlpha24, t)!,
      primaryAlpha16: Color.lerp(primaryAlpha16, other.primaryAlpha16, t)!,
      primaryAlpha10: Color.lerp(primaryAlpha10, other.primaryAlpha10, t)!,
      bgStrong950: Color.lerp(bgStrong950, other.bgStrong950, t)!,
      bgSurface800: Color.lerp(bgSurface800, other.bgSurface800, t)!,
      bgSub300: Color.lerp(bgSub300, other.bgSub300, t)!,
      bgSoft200: Color.lerp(bgSoft200, other.bgSoft200, t)!,
      bgWeak50: Color.lerp(bgWeak50, other.bgWeak50, t)!,
      bgWhite0: Color.lerp(bgWhite0, other.bgWhite0, t)!,
      textStrong950: Color.lerp(textStrong950, other.textStrong950, t)!,
      textSub600: Color.lerp(textSub600, other.textSub600, t)!,
      textSoft400: Color.lerp(textSoft400, other.textSoft400, t)!,
      textDisabled300: Color.lerp(textDisabled300, other.textDisabled300, t)!,
      textWhite0: Color.lerp(textWhite0, other.textWhite0, t)!,
      strokeStrong950: Color.lerp(strokeStrong950, other.strokeStrong950, t)!,
      strokeSub300: Color.lerp(strokeSub300, other.strokeSub300, t)!,
      strokeSoft200: Color.lerp(strokeSoft200, other.strokeSoft200, t)!,
      strokeWhite0: Color.lerp(strokeWhite0, other.strokeWhite0, t)!,
      informationDark: Color.lerp(informationDark, other.informationDark, t)!,
      informationBase: Color.lerp(informationBase, other.informationBase, t)!,
      informationLight:
          Color.lerp(informationLight, other.informationLight, t)!,
      informationLighter:
          Color.lerp(informationLighter, other.informationLighter, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      warningBase: Color.lerp(warningBase, other.warningBase, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningLighter: Color.lerp(warningLighter, other.warningLighter, t)!,
      errorDark: Color.lerp(errorDark, other.errorDark, t)!,
      errorBase: Color.lerp(errorBase, other.errorBase, t)!,
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      errorLighter: Color.lerp(errorLighter, other.errorLighter, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      successBase: Color.lerp(successBase, other.successBase, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successLighter: Color.lerp(successLighter, other.successLighter, t)!,
    );
  }
}

final class AppColorPalette {
  const AppColorPalette._();

  static const grey950 = Color.fromRGBO(23, 23, 23, 1);
  static const grey900 = Color.fromRGBO(28, 28, 28, 1);
  static const grey800 = Color.fromRGBO(41, 41, 41, 1);
  static const grey700 = Color.fromRGBO(51, 51, 51, 1);
  static const grey600 = Color.fromRGBO(92, 92, 92, 1);
  static const grey500 = Color.fromRGBO(123, 123, 123, 1);
  static const grey400 = Color.fromRGBO(163, 163, 163, 1);
  static const grey300 = Color.fromRGBO(209, 209, 209, 1);
  static const grey200 = Color.fromRGBO(235, 235, 235, 1);
  static const grey100 = Color.fromRGBO(245, 245, 245, 1);
  static const grey50 = Color.fromRGBO(250, 250, 250, 1);
  static const grey0 = Color.fromRGBO(255, 255, 255, 1);
  static const greyAlpha24 = Color.fromRGBO(163, 163, 163, 0.24);
  static const greyAlpha16 = Color.fromRGBO(163, 163, 163, 0.16);
  static const greyAlpha10 = Color.fromRGBO(163, 163, 163, 0.10);

  static const neutral950 = grey950;
  static const neutral900 = grey900;
  static const neutral800 = grey800;
  static const neutral700 = grey700;
  static const neutral600 = grey600;
  static const neutral500 = grey500;
  static const neutral400 = grey400;
  static const neutral300 = grey300;
  static const neutral200 = grey200;
  static const neutral100 = grey100;
  static const neutral50 = grey50;
  static const neutral0 = grey0;
  static const neutralAlpha24 = greyAlpha24;
  static const neutralAlpha16 = greyAlpha16;
  static const neutralAlpha10 = greyAlpha10;

  static const red950 = Color.fromRGBO(104, 18, 25, 1);
  static const red900 = Color.fromRGBO(139, 24, 34, 1);
  static const red800 = Color.fromRGBO(173, 31, 43, 1);
  static const red700 = Color.fromRGBO(208, 37, 51, 1);
  static const red600 = Color.fromRGBO(233, 53, 68, 1);
  static const red500 = Color.fromRGBO(251, 55, 72, 1);
  static const red400 = Color.fromRGBO(255, 104, 117, 1);
  static const red300 = Color.fromRGBO(255, 151, 160, 1);
  static const red200 = Color.fromRGBO(255, 192, 197, 1);
  static const red100 = Color.fromRGBO(255, 213, 216, 1);
  static const red50 = Color.fromRGBO(255, 235, 236, 1);
  static const redAlpha24 = Color.fromRGBO(251, 55, 72, 0.24);
  static const redAlpha16 = Color.fromRGBO(251, 55, 72, 0.16);
  static const redAlpha10 = Color.fromRGBO(251, 55, 72, 0.10);

  static const orange950 = Color.fromRGBO(145, 66, 12, 1);
  static const orange900 = Color.fromRGBO(145, 66, 12, 1);
  static const orange800 = Color.fromRGBO(184, 84, 16, 1);
  static const orange700 = Color.fromRGBO(217, 98, 19, 1);
  static const orange600 = Color.fromRGBO(250, 113, 12, 1);
  static const orange500 = Color.fromRGBO(250, 74, 12, 1);
  static const orange400 = Color.fromRGBO(255, 164, 104, 1);
  static const orange300 = Color.fromRGBO(255, 193, 151, 1);
  static const orange200 = Color.fromRGBO(255, 217, 192, 1);
  static const orange100 = Color.fromRGBO(255, 230, 213, 1);
  static const orange50 = Color.fromRGBO(255, 243, 235, 1);
  static const orangeAlpha24 = Color.fromRGBO(255, 145, 71, 0.24);
  static const orangeAlpha16 = Color.fromRGBO(255, 145, 71, 0.16);
  static const orangeAlpha10 = Color.fromRGBO(255, 145, 71, 0.10);

  static const yellow950 = Color.fromRGBO(98, 76, 24, 1);
  static const yellow900 = Color.fromRGBO(134, 102, 29, 1);
  static const yellow800 = Color.fromRGBO(167, 128, 37, 1);
  static const yellow700 = Color.fromRGBO(201, 154, 44, 1);
  static const yellow600 = Color.fromRGBO(230, 168, 25, 1);
  static const yellow500 = Color.fromRGBO(246, 181, 30, 1);
  static const yellow400 = Color.fromRGBO(255, 210, 104, 1);
  static const yellow300 = Color.fromRGBO(255, 224, 151, 1);
  static const yellow200 = Color.fromRGBO(255, 236, 192, 1);
  static const yellow100 = Color.fromRGBO(255, 239, 204, 1);
  static const yellow50 = Color.fromRGBO(255, 244, 214, 1);

  static const green950 = Color.fromRGBO(11, 70, 39, 1);
  static const green900 = Color.fromRGBO(22, 100, 59, 1);
  static const green800 = Color.fromRGBO(26, 117, 68, 1);
  static const green700 = Color.fromRGBO(23, 140, 78, 1);
  static const green600 = Color.fromRGBO(29, 175, 97, 1);
  static const green500 = Color.fromRGBO(31, 193, 107, 1);
  static const green400 = Color.fromRGBO(62, 224, 137, 1);
  static const green300 = Color.fromRGBO(132, 235, 180, 1);
  static const green200 = Color.fromRGBO(194, 245, 218, 1);
  static const green100 = Color.fromRGBO(208, 251, 233, 1);
  static const green50 = Color.fromRGBO(224, 250, 236, 1);

  static const blue950 = Color.fromRGBO(18, 35, 104, 1);
  static const blue900 = Color.fromRGBO(24, 47, 139, 1);
  static const blue800 = Color.fromRGBO(31, 59, 173, 1);
  static const blue700 = Color.fromRGBO(37, 71, 208, 1);
  static const blue600 = Color.fromRGBO(53, 89, 233, 1);
  static const blue500 = Color.fromRGBO(51, 92, 255, 1);
  static const blue400 = Color.fromRGBO(104, 149, 255, 1);
  static const blue300 = Color.fromRGBO(151, 186, 255, 1);
  static const blue200 = Color.fromRGBO(192, 213, 255, 1);
  static const blue100 = Color.fromRGBO(213, 226, 255, 1);
  static const blue50 = Color.fromRGBO(235, 241, 255, 1);

  static const purple950 = Color.fromRGBO(53, 26, 117, 1);
  static const purple900 = Color.fromRGBO(61, 29, 134, 1);
  static const purple800 = Color.fromRGBO(76, 37, 167, 1);
  static const purple700 = Color.fromRGBO(91, 44, 201, 1);
  static const purple600 = Color.fromRGBO(105, 62, 224, 1);
  static const purple500 = Color.fromRGBO(125, 82, 244, 1);
  static const purple400 = Color.fromRGBO(140, 113, 246, 1);
  static const purple300 = Color.fromRGBO(168, 151, 255, 1);
  static const purple200 = Color.fromRGBO(202, 192, 255, 1);
  static const purple100 = Color.fromRGBO(220, 213, 255, 1);
  static const purple50 = Color.fromRGBO(239, 235, 255, 1);
  static const purpleAlpha24 = Color.fromRGBO(120, 77, 239, 0.24);
  static const purpleAlpha16 = Color.fromRGBO(120, 77, 239, 0.16);
  static const purpleAlpha10 = Color.fromRGBO(120, 77, 239, 0.10);
}
