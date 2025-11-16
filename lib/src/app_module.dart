import 'package:auth/auth.dart';
import 'package:shared/shared.dart';
import 'package:ui/ui.dart';

class AppModule {
  AppModule._();

  static void init() {
    final List<BaseModule> packages = [SharedModule(), UIModule(), AuthModule()];
    for (var module in packages) {
      module.setupDependencies();
    }
  }
}
