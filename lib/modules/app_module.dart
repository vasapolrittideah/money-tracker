import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:user/user.dart';

class AppModule {
  AppModule._();

  static final List<BaseModule> _modules = [];

  static Future<void> init() async {
    _modules.addAll([CoreModule(), AuthModule(), UserModule()]);

    await _initModules();
  }

  static Future<void> _initModules() async {
    for (final module in _modules) {
      module.init();
    }
  }
}
