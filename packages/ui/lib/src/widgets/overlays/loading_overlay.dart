import 'package:ui/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/widgets/feedback/circular_progress.dart';

// Showcases the duration of a process or an indefinite wait period.
class AppLoadingOverlay {
  AppLoadingOverlay._();

  static bool isLoading = false;
  static const loadingRouteSettings = RouteSettings(name: 'loading');

  static void start(BuildContext context) {
    if (!isLoading) {
      isLoading = true;

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
                child: AppCircularProgress(),
              ),
            ),
          );
        },
      );
    }
  }

  static void stop(BuildContext context) {
    if (isLoading) {
      isLoading = false;

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}
