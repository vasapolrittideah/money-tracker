import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.x6s,
    required this.x5s,
    required this.x4s,
    required this.x3s,
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
  });

  static final spacing = AppSpacing(
    x6s: 2.r,
    x5s: 4.r,
    x4s: 8.r,
    x3s: 12.r,
    x2s: 16.r,
    xs: 24.r,
    sm: 32.r,
    md: 40.r,
    lg: 48.r,
    xl: 56.r,
    x2l: 64.r,
  );

  final double x6s;
  final double x5s;
  final double x4s;
  final double x3s;
  final double x2s;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double x2l;

  @override
  AppSpacing copyWith({
    double? x6s,
    double? x5s,
    double? x4s,
    double? x3s,
    double? x2s,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? x2l,
  }) {
    return AppSpacing(
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) {
      return this;
    }

    return AppSpacing(
      x6s: lerpDouble(x6s, other.x6s, t)!,
      x5s: lerpDouble(x5s, other.x5s, t)!,
      x4s: lerpDouble(x4s, other.x4s, t)!,
      x3s: lerpDouble(x3s, other.x3s, t)!,
      x2s: lerpDouble(x2s, other.x2s, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      x2l: lerpDouble(x2l, other.x2l, t)!,
    );
  }
}
