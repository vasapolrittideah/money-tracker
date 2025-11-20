import 'package:flutter/material.dart';
import 'package:shared/libs.dart';

part 'locale_model.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class LocaleModel extends HiveObject with _$LocaleModel {
  LocaleModel._();

  factory LocaleModel({required String languageCode, String? countryCode}) = _LocaleModel;

  Locale toLocale() => Locale(languageCode, countryCode);
}
