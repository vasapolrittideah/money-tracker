import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppBorders extends ThemeExtension<AppBorders> {
  const AppBorders({
    required this.radiusX2s,
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusFull,
    required this.defaultWidth,
  });
  static final borders = AppBorders(
    radiusX2s: 2.0.r,
    radiusXs: 4.0.r,
    radiusSm: 8.0.r,
    radiusMd: 10.0.r,
    radiusLg: 12.0.r,
    radiusFull: 999.0.r,
    defaultWidth: 1.0.r,
  );

  final double radiusX2s;
  final double radiusXs;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusFull;
  final double defaultWidth;

  @override
  AppBorders copyWith({
    double? radiusX2s,
    double? radiusXs,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusFull,
    double? defaultWidth,
  }) {
    return AppBorders(
      radiusX2s: radiusX2s ?? this.radiusX2s,
      radiusXs: radiusXs ?? this.radiusXs,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusFull: radiusFull ?? this.radiusFull,
      defaultWidth: defaultWidth ?? this.defaultWidth,
    );
  }

  @override
  AppBorders lerp(ThemeExtension<AppBorders>? other, double t) {
    if (other is! AppBorders) {
      return this;
    }

    return AppBorders(
      radiusX2s: lerpDouble(radiusX2s, other.radiusX2s, t)!,
      radiusXs: lerpDouble(radiusXs, other.radiusXs, t)!,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t)!,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t)!,
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t)!,
      radiusFull: lerpDouble(radiusFull, other.radiusFull, t)!,
      defaultWidth: lerpDouble(defaultWidth, other.defaultWidth, t)!,
    );
  }
}
