import 'package:ui/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Showcases the duration of a process or an indefinite wait period.
class AppLoadingOverlay {
  AppLoadingOverlay._();

  static bool loading = false;
  static const loadingRouteSettins = RouteSettings(name: 'loading');

  static void start(BuildContext context) {
    if (loading) {
      loading = true;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(context.appSpacing.x2s),
                decoration: BoxDecoration(
                  color: context.appColors.staticWhite,
                  boxShadow: context.appShadows.xs,
                  borderRadius: BorderRadius.circular(context.appBorders.borderRadiusMd),
                ),
                child: SizedBox(
                  width: context.appSpacing.xs,
                  height: context.appSpacing.xs,
                  child: CircularProgressIndicator(
                    color: context.appColors.bgStrong950,
                    backgroundColor: context.appColors.bgSoft200,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.r,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void stop(BuildContext context) {
    if (loading) {
      loading = false;

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}
