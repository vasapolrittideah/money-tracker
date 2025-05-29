import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:data/data.dart';

class AppModule {
  AppModule._();

  static final List<BaseModule> _modules = [];

  static Future<void> init() async {
    _modules.addAll([AuthModule(), DataModule()]);

    await _register();
  }

  static Future<void> _register() async {
    for (final module in _modules) {
      module.register();
    }
  }
}
