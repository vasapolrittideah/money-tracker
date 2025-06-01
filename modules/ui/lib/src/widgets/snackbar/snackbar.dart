import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

enum SnackBarType { infomation, success, failure }

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.infomation,
  }) {
    switch (type) {
      case SnackBarType.infomation:
        _CustomSnackBar.show(
          context: context,
          message: message,
          iconData: FontAwesomeIcons.circleInfo,
          backgroundColor: context.appColors.primaryBase,
        );
        break;
      case SnackBarType.success:
        _CustomSnackBar.show(
          context: context,
          message: message,
          iconData: FontAwesomeIcons.solidCircleCheck,
          backgroundColor: context.appColors.successBase,
        );
        break;
      case SnackBarType.failure:
        _CustomSnackBar.show(
          context: context,
          message: message,
          iconData: FontAwesomeIcons.circleExclamation,
          backgroundColor: context.appColors.errorBase,
        );
        break;
    }
  }
}

class _CustomSnackBar {
  _CustomSnackBar._();

  static void show({
    required BuildContext context,
    required String message,
    required IconData iconData,
    Color? backgroundColor,
    Color? messageColor,
  }) {
    backgroundColor ??= context.appColors.primaryBase;
    messageColor ??= context.appColors.staticWhite;

    final flushbar = Flushbar(
      padding: EdgeInsets.only(
        top: context.appSpacing.xs,
        left: context.appSpacing.sm,
        right: context.appSpacing.sm,
        bottom: context.appSpacing.x2s,
      ),
      progressIndicatorBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      messageColor: messageColor,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageSize: context.appTypography.regular.textDefault.fontSize,
      animationDuration: const Duration(milliseconds: 300),
      messageText: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.appSpacing.x6s),
              child: FaIcon(
                iconData,
                color: context.appColors.staticWhite,
                size: context.appTypography.regular.text16.fontSize,
              ),
            ),
            SizedBox(width: context.appSpacing.x4s),
            Flexible(
              child: Text(
                message,
                style: context.appTypography.regular.textDefault.copyWith(
                  color: messageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    flushbar.show(context);
  }
}
