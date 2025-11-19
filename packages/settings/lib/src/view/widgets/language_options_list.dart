import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/src/logic/cubits/locale/locale_cubit.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class LanguageOptionsList extends HookWidget {
  const LanguageOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.read<LocaleCubit>().state.locale;
    final selectedLocale = useState<Locale?>(currentLocale?.toLocale());

    final locales = context.supportedLocales;

    return BlocListener<LocaleCubit, LocaleState>(
      listener: (context, state) {
        if (state.isLoading) {
          AppLoadingOverlay.start(context);
        } else {
          AppLoadingOverlay.stop(context);
        }
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _LanguageOptionTile(
            locale: locales[index],
            index: index,
            isSelected: locales[index] == selectedLocale.value,
            onTap: () async {
              await context.read<LocaleCubit>().saveLocale(
                LocaleModel(languageCode: locales[index].languageCode, countryCode: locales[index].countryCode ?? ''),
              );

              if (context.mounted) {
                context.setLocale(locales[index]);
                selectedLocale.value = locales[index];
                context.pop();
              }
            },
          );
        },
        itemCount: locales.length,
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({required this.index, required this.locale, required this.onTap, this.isSelected = false});

  final int index;
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final languageName = switch (locale.languageCode) {
      'en' => 'English',
      'th' => 'ไทย',
      _ => locale.languageCode,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.appSpacing.x3s),
        margin: EdgeInsets.only(
          bottom: index == 0 ? context.appSpacing.x3s : 0,
          top: index == 0 ? context.appSpacing.x2s : 0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? context.appColors.bgSoft200 : context.appColors.staticWhite,
          borderRadius: BorderRadius.circular(context.appBorders.borderRadiusMd),
          border: Border.all(color: isSelected ? context.appColors.strokeStrong950 : context.appColors.strokeSub300),
        ),
        child: Row(
          children: [
            CountryFlag.fromLanguageCode(
              locale.languageCode,
              theme: ImageTheme(width: context.appSpacing.xs, height: context.appSpacing.xs, shape: Circle()),
            ),
            SizedBox(width: context.appSpacing.x2s),
            Row(
              children: [
                Text(
                  locale.languageCode.toUpperCase(),
                  style: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSub600),
                ),
                Text(
                  ' / $languageName',
                  style: context.appTypography.regular.textDefault.copyWith(color: context.appColors.textSub600),
                ),
              ],
            ),
            Spacer(),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: context.appSpacing.x5s),
                child: FaIcon(
                  FontAwesomeIcons.check,
                  color: context.appColors.textStrong950,
                  size: context.appTypography.regular.textDefault.fontSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
