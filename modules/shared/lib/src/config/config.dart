import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  AppConfig();

  late final String appName;
  late final String apiBaseUrl;

  Future<void> load() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final env = packageInfo.packageName.split('.').last.toLowerCase();

    final jsonString = await rootBundle.loadString('assets/config/$env.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    appName = jsonMap['appName'];
    apiBaseUrl = jsonMap['apiBaseUrl'];
  }
}
