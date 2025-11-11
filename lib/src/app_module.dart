import 'package:shared/shared.dart';

class AppModule {
  AppModule._();

  static void init() {
    final List<BaseModule> modules = [SharedModule()];
    for (var module in modules) {
      module.setupDependencies();
    }
  }
}
