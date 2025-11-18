import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'locale_model.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class LocaleModel extends HiveObject with _$LocaleModel {
  LocaleModel._();

  factory LocaleModel({required String languageCode, String? countryCode}) = _LocaleModel;

  Locale toLocale() => Locale(languageCode, countryCode);
}
