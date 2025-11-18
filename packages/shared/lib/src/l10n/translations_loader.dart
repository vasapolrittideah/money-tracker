import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiPackageAssetLoader extends AssetLoader {
  final List<String> assetPaths;

  MultiPackageAssetLoader(this.assetPaths);

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    Map<String, dynamic> combinedTranslations = {};

    for (String assetPath in assetPaths) {
      try {
        String fullPath = '$assetPath/${locale.toString()}.json';
        String data = await rootBundle.loadString(fullPath);
        Map<String, dynamic> translations = json.decode(data);
        combinedTranslations.addAll(translations);
      } catch (e) {
        debugPrint('Error loading $assetPath for $locale: $e');
      }
    }

    return combinedTranslations;
  }
}
