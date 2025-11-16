import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppBorders extends ThemeExtension<AppBorders> {
  const AppBorders({
    required this.borderRadiusX2s,
    required this.borderRadiusXs,
    required this.borderRadiusSm,
    required this.borderRadiusMd,
    required this.borderRadiusLg,
    required this.borderRadiusFull,
    required this.defaultBorderWidth,
  });
  static final borders = AppBorders(
    borderRadiusX2s: 2.0.r,
    borderRadiusXs: 4.0.r,
    borderRadiusSm: 8.0.r,
    borderRadiusMd: 12.0.r,
    borderRadiusLg: 16.0.r,
    borderRadiusFull: 999.0.r,
    defaultBorderWidth: 1.0.r,
  );

  final double borderRadiusX2s;
  final double borderRadiusXs;
  final double borderRadiusSm;
  final double borderRadiusMd;
  final double borderRadiusLg;
  final double borderRadiusFull;
  final double defaultBorderWidth;

  @override
  AppBorders copyWith({
    double? borderRadiusX2s,
    double? borderRadiusXs,
    double? borderRadiusSm,
    double? borderRadiusMd,
    double? borderRadiusLg,
    double? borderRadiusFull,
    double? defaultBorderWidth,
  }) {
    return AppBorders(
      borderRadiusX2s: borderRadiusX2s ?? this.borderRadiusX2s,
      borderRadiusXs: borderRadiusXs ?? this.borderRadiusXs,
      borderRadiusSm: borderRadiusSm ?? this.borderRadiusSm,
      borderRadiusMd: borderRadiusMd ?? this.borderRadiusMd,
      borderRadiusLg: borderRadiusLg ?? this.borderRadiusLg,
      borderRadiusFull: borderRadiusFull ?? this.borderRadiusFull,
      defaultBorderWidth: defaultBorderWidth ?? this.defaultBorderWidth,
    );
  }

  @override
  AppBorders lerp(ThemeExtension<AppBorders>? other, double t) {
    if (other is! AppBorders) {
      return this;
    }

    return AppBorders(
      borderRadiusX2s: lerpDouble(borderRadiusX2s, other.borderRadiusX2s, t)!,
      borderRadiusXs: lerpDouble(borderRadiusXs, other.borderRadiusXs, t)!,
      borderRadiusSm: lerpDouble(borderRadiusSm, other.borderRadiusSm, t)!,
      borderRadiusMd: lerpDouble(borderRadiusMd, other.borderRadiusMd, t)!,
      borderRadiusLg: lerpDouble(borderRadiusLg, other.borderRadiusLg, t)!,
      borderRadiusFull: lerpDouble(borderRadiusFull, other.borderRadiusFull, t)!,
      defaultBorderWidth: lerpDouble(defaultBorderWidth, other.defaultBorderWidth, t)!,
    );
  }
}
