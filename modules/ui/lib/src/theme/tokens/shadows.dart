import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({required this.regularXSmall, this.regularMedium});

  final List<BoxShadow> regularXSmall;
  final List<BoxShadow>? regularMedium;

  static final light = AppShadows(
    regularXSmall: [
      BoxShadow(
        color: Color.fromRGBO(10, 13, 20, 0.04),
        blurRadius: 2.r,
        spreadRadius: 0,
        offset: Offset(0, 1.h),
      ),
    ],
    regularMedium: [
      BoxShadow(
        color: Color.fromRGBO(14, 18, 27, 0.10),
        blurRadius: 32.r,
        spreadRadius: -12.r,
        offset: Offset(0, 16.h),
      ),
    ],
  );

  @override
  AppShadows copyWith({
    List<BoxShadow>? regularXSmall,
    List<BoxShadow>? regularMedium,
  }) {
    return AppShadows(
      regularXSmall: regularXSmall ?? this.regularXSmall,
      regularMedium: regularMedium ?? this.regularMedium,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) {
      return this;
    }
    return AppShadows(
      regularXSmall: BoxShadow.lerpList(regularXSmall, other.regularXSmall, t)!,
      regularMedium: BoxShadow.lerpList(regularMedium, other.regularMedium, t),
    );
  }
}
