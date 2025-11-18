import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:settings/generated/locale_keys.g.dart';
import 'package:settings/src/view/widgets/language_options_list.dart';
import 'package:ui/ui.dart';

class SelectLanguageBottomSheet {
  SelectLanguageBottomSheet._();

  static Future<void> show(BuildContext context) async {
    await AppBottomSheet.show(
      context: context,
      title: SettingsLocaleKeys.selectLanguage_title.tr(),
      maxHeight: 300.h,
      child: LanguageOptionsList(),
    );
  }
}
