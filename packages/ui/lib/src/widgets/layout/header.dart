import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, this.title, this.titleWidget, this.action, this.leading, this.includeBackButton = false});

  final String? title;
  final Widget? titleWidget;
  final Widget? action;
  final Widget? leading;
  final bool includeBackButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: context.appColors.staticWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.xs),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (includeBackButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: FaIcon(FontAwesomeIcons.arrowLeft, color: context.appColors.textStrong950),
                  ),
                )
              else if (leading != null)
                Align(alignment: Alignment.centerLeft, child: leading!),

              if (title != null)
                Text(title!, style: context.appTypography.medium.text20)
              else if (titleWidget != null)
                titleWidget!,

              if (action != null) Align(alignment: Alignment.centerRight, child: action!),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}
