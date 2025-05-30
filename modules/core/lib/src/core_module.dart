import 'package:core/core.dart';
import 'package:core/src/data/local/hive/hive_manager.dart';
import 'package:core/src/data/local/primitive/primitive_database.dart';
import 'package:core/src/data/local/secure/secure_storage_manager.dart';
import 'package:core/src/data/local/token/token_operation.dart';
import 'package:core/src/data/local/token/token_storage_manager.dart';
import 'package:core/src/data/remote/dio_factory.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoreModule extends BaseModule {
  static final CoreModule _instance = CoreModule._internal();

  factory CoreModule() => _instance;

  CoreModule._internal();

  @override
  void init() {
    register();

    sl<HiveManger>().init();
  }

  @override
  void register() async {
    sl.registerSingleton(Hive);
    sl.registerLazySingleton(() => DioFactory.getInstance());
    sl.registerLazySingleton<PrimitiveDatabase>(
      () => SecureStorageManager<String>(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        ),
      ),
    );
    sl.registerLazySingleton(() => HiveOperation<Jwt>(sl(), sl()));
    sl<HiveInterface>().registerAdapter(JwtAdapter());
    sl.registerLazySingleton(() => HiveManger(sl()));
    sl.registerLazySingleton(
      () => ApiClient(sl(), TokenOperation(TokenStorageManager(sl()))),
    );
  }
}
