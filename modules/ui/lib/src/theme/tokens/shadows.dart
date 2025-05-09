import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({required this.xs, this.md});

  final List<BoxShadow> xs;
  final List<BoxShadow>? md;

  static final light = AppShadows(
    xs: [
      BoxShadow(
        color: Color.fromRGBO(10, 13, 20, 0.04),
        blurRadius: 2.r,
        spreadRadius: 0,
        offset: Offset(0, 1.h),
      ),
    ],
    md: [
      BoxShadow(
        color: Color.fromRGBO(14, 18, 27, 0.10),
        blurRadius: 32.r,
        spreadRadius: -12.r,
        offset: Offset(0, 16.h),
      ),
    ],
  );

  @override
  AppShadows copyWith({List<BoxShadow>? xs, List<BoxShadow>? md}) {
    return AppShadows(xs: xs ?? this.xs, md: md ?? this.md);
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) {
      return this;
    }
    return AppShadows(
      xs: BoxShadow.lerpList(xs, other.xs, t)!,
      md: BoxShadow.lerpList(md, other.md, t),
    );
  }
}
