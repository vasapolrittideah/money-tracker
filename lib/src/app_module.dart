import 'package:auth/auth.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class AppModule {
  AppModule._();

  static void init() {
    final List<BaseModule> modules = [SharedModule(), UIModule(), AuthModule()];
    for (var module in modules) {
      module.setupDependencies();
    }
  }
}
