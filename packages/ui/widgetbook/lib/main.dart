import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return Widgetbook(
      appBuilder: (context, child) => ScreenUtilInit(
        minTextAdapt: true,
        ensureScreenSize: true,
        designSize: const Size(360, 690),
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            UILocalizations.delegate,
          ],
          supportedLocales: UILocalizations.delegate.supportedLocales,
          localeListResolutionCallback: (locales, supportedLocales) {
            const defaultLocale = Locale('th', 'TH');
            return _setDefaultLocale(locales, supportedLocales, defaultLocale);
          },
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.transparent,
            extensions: <ThemeExtension<dynamic>>[AppThemes(tokens: AppTokens.light)],
          ),
          home: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Align(alignment: Alignment.topCenter, child: child),
            ),
          ),
        ),
      ),
      directories: directories,
    );
  }

  Locale _setDefaultLocale(List<Locale>? locales, Iterable<Locale> supportedLocales, Locale defaultLocale) {
    return locales?.firstWhere((locale) => supportedLocales.contains(locale), orElse: () => defaultLocale) ??
        defaultLocale;
  }
}
