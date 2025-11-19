import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings/settings.dart';
import 'package:ui/ui.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.read<LocaleCubit>().state.locale;

    return GestureDetector(
      onTap: () => SelectLanguageBottomSheet.show(context),
      child: AppButton(
        text: currentLocale?.languageCode.toUpperCase() ?? '',
        prefix: FaIcon(
          FontAwesomeIcons.language,
          size: context.appTypography.regular.textDefault.fontSize,
          color: context.appColors.textSub600,
        ),
        mode: AppButtonMode.stroke,
        variant: AppButtonVariant.neutral,
        size: AppButtonSize.xs,
        onTap: () => SelectLanguageBottomSheet.show(context),
      ),
    );
  }
}
