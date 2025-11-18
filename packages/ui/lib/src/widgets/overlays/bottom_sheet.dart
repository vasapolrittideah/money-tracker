import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: context.appColors.staticWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.appBorders.borderRadiusLg)),
      ),
      builder: (context) {
        final height = maxHeight ?? MediaQuery.of(context).size.height * 0.6;

        return SizedBox(
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grab handle
              SizedBox(
                height: 40.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.appColors.bgWeak50,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(context.appBorders.borderRadiusLg)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x2s),
                  child: Stack(
                    children: [
                      // Title
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: context.appSpacing.x3s),
                          child: Text(title ?? '', style: context.appTypography.bold.text16),
                        ),
                      ),

                      // Close button
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: context.appSpacing.x3s - 2.h),
                            padding: EdgeInsets.all(6.h),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: context.appColors.bgSoft200),
                            child: FaIcon(
                              FontAwesomeIcons.xmark,
                              size: context.appTypography.regular.textDefault.fontSize,
                              color: context.appColors.textSub600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (title != null) AppDivider(),

              // Custom content
              Expanded(
                child: Padding(
                  padding: padding ?? EdgeInsets.symmetric(horizontal: context.appSpacing.x2s),
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
