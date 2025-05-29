import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/src/local/primitive/primitive_database.dart';
import 'package:data/src/local/secure/secure_storage_manager.dart';
import 'package:data/src/local/token/token_operation.dart';
import 'package:data/src/local/token/token_storage_manager.dart';
import 'package:data/src/remote/dio_factory.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataModule extends BaseModule {
  static final DataModule _instance = DataModule._internal();

  factory DataModule() => _instance;

  DataModule._internal();

  @override
  void init() {
    register();
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
    sl.registerLazySingleton(() => HiveManger(sl()));
    sl.registerLazySingleton(
      () => ApiClient(sl(), TokenOperation(TokenStorageManager(sl()))),
    );

    _registerHiveOperations();
    _registerHiveAdapters();
  }

  void _registerHiveOperations() {
    sl.registerLazySingleton(() => HiveOperation<Jwt>(sl(), sl()));
  }

  void _registerHiveAdapters() {
    sl<HiveInterface>().registerAdapter(JwtAdapter());
  }
}
