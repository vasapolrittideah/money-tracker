import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Environment { dev, prod, staging }

class AppConfig {
  AppConfig._();

  static late Environment environment;
  static late String authApiUrl;
  static late String userApiUrl;

  static Future<void> init() async {
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final envSuffix = packageName.split(".").last.toLowerCase();

    environment = switch (envSuffix) {
      'dev' => Environment.dev,
      'staging' => Environment.staging,
      _ => Environment.prod,
    };

    final envFile = switch (environment) {
      Environment.dev => '.env.dev',
      Environment.staging => '.env.staging',
      Environment.prod => '.env.prod',
    };

    await dotenv.load(fileName: envFile);

    // Assign env to static variables
    authApiUrl = dotenv.env['AUTH_API_URL'] ?? '';
    userApiUrl = dotenv.env['USER_API_URL'] ?? '';
  }
}
