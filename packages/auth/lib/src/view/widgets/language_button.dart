import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings/settings.dart';
import 'package:ui/ui.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.read<LocaleCubit>().state.locale;

    return GestureDetector(
      onTap: () => SelectLanguageBottomSheet.show(context),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.strokeStrong950.withAlpha(120),
          borderRadius: BorderRadius.circular(context.appBorders.borderRadiusFull),
          boxShadow: context.appShadows.xs,
        ),
        padding: EdgeInsets.all(context.appBorders.defaultBorderWidth),
        child: CountryFlag.fromLanguageCode(
          currentLocale?.languageCode ?? '',
          theme: ImageTheme(width: context.appSpacing.xs, height: context.appSpacing.xs, shape: Circle()),
        ),
      ),
    );
  }
}
