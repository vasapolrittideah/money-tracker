import 'package:core/core.dart';
import 'package:user/src/models/user.dart';
import 'package:user/src/repositories/user_repository.dart';

class UserModule extends BaseModule {
  static final UserModule _instance = UserModule._internal();

  factory UserModule() => _instance;

  UserModule._internal();

  @override
  void init() {
    register();
  }

  @override
  void register() async {
    sl.registerLazySingleton(() => HiveOperation<User>(sl(), sl()));
    sl<HiveInterface>().registerAdapter(UserAdapter());
    sl.registerLazySingleton(() => UserRepository(sl()));
  }
}
