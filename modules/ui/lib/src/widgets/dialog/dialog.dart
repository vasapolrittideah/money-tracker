import 'package:flutter/material.dart';
import 'package:ui/src/theme/theme.dart';
import 'package:ui/src/widgets/spinner/spinner.dart';

class AppDialog {
  AppDialog._();

  static const loadingRouteSettings = RouteSettings(name: 'loading');
  static bool _isLoading = false;

  static void startLoading(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        routeSettings: loadingRouteSettings,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(context.appSpacing.x2s),
                decoration: BoxDecoration(
                  color: context.appColors.staticWhite,
                  boxShadow: context.appShadows.xs,
                  borderRadius: BorderRadius.circular(
                    context.appBorders.radiusMd,
                  ),
                ),
                child: AppSpinner(),
              ),
            ),
          );
        },
      );
    }

    return;
  }

  static void stopLoading(BuildContext context) {
    if (_isLoading) {
      _isLoading = false;

      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
