import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      appBuilder:
          (context, child) => ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            ensureScreenSize: true,
            builder:
                (context, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.light().copyWith(
                    scaffoldBackgroundColor: Colors.white,
                    extensions: <ThemeExtension<dynamic>>[
                      AppTheme(tokens: AppTokens.light),
                    ],
                  ),
                  home: Builder(
                    builder:
                        (context) => Padding(
                          padding: EdgeInsets.all(context.appSpacing.x4s),
                          child: child,
                        ),
                  ),
                ),
          ),
    );
  }
}
