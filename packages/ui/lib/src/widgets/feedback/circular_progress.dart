import 'package:flutter/material.dart';
import 'package:shared/libs.dart';
import 'package:ui/ui.dart';

class AppCircularProgress extends StatelessWidget {
  const AppCircularProgress({super.key, this.size, this.strokeWidth, this.color});

  final double? size;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 24.r;

    final effectiveStrokeWidth = strokeWidth ?? 3.r;

    return SizedBox(
      width: effectiveSize,
      height: effectiveSize,
      child: CircularProgressIndicator(
        color: context.appColors.bgStrong950,
        backgroundColor: context.appColors.bgSoft200,
        strokeCap: StrokeCap.round,
        strokeWidth: effectiveStrokeWidth,
      ),
    );
  }
}
