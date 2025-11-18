import 'package:ui/src/themes/themes.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.thickness, this.text = '', this.padding = EdgeInsets.zero});

  final String text;
  final double? thickness;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Padding(
        padding: padding,
        child: Divider(
          color: context.appColors.strokeSub300,
          thickness: thickness,
          height: context.appBorders.defaultBorderWidth,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: context.appColors.strokeSub300,
              thickness: thickness,
              height: context.appBorders.defaultBorderWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x4s),
            child: Text(
              text,
              style: context.appTypography.regular.text12.copyWith(color: context.appColors.textSub600),
            ),
          ),
          Expanded(
            child: Divider(
              color: context.appColors.strokeSub300,
              thickness: thickness,
              height: context.appBorders.defaultBorderWidth,
            ),
          ),
        ],
      ),
    );
  }
}
