import 'package:core/core.dart';

class AuthModule extends BaseModule {
  static final AuthModule _instance = AuthModule._internal();

  factory AuthModule() => _instance;

  AuthModule._internal();

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void register() {}
}
