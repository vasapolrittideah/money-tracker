import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/src/theme/theme.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.appSpacing.xs,
      height: context.appSpacing.xs,
      child: CircularProgressIndicator(
        color: context.appColors.bgStrong950,
        backgroundColor: context.appColors.bgSoft200,
        strokeCap: StrokeCap.round,
        strokeWidth: 3.r,
      ),
    );
  }
}
