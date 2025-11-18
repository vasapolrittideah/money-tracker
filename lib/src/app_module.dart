import 'package:auth/auth.dart';
import 'package:settings/settings.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class AppModule {
  AppModule._();

  static final List<BaseModule> _packages = [SharedModule(), UiModule(), AuthModule(), SettingsModule()];

  static void init() {
    for (var module in _packages) {
      module.setupDependencies();
    }
  }

  static List<String> get translationsAssets {
    final List<String> assets = ['assets/translations'];

    for (var module in _packages) {
      assets.add('packages/${module.name}/assets/translations');
    }

    return assets;
  }
}
