import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';
import 'package:shared/src/config/config.dart';
import 'package:shared/src/injection/service_locator.dart';
import 'package:shared/src/managers/session_manager.dart';
import 'package:shared/src/models/session/session_model.dart';
import 'package:shared/src/module/base_module.dart';
import 'package:shared/src/network/dio_client.dart';
import 'package:shared/src/network/dio_factory.dart';
import 'package:shared/src/storage/hive_encryption.dart';
import 'package:shared/src/storage/hive_manager.dart';
import 'package:shared/src/storage/hive_storage.dart';
import 'package:shared/src/storage/secure_storage.dart';
import 'package:shared/src/utilities/directory_util.dart';

class SharedModule extends BaseModule {
  @override
  String get name => 'shared';

  @override
  void setupDependencies() {
    sl.registerSingleton(Hive);

    sl.registerLazySingleton(() => DioFactory.getInstance());

    sl.registerLazySingleton(
      () => SecureStorage(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        ),
      ),
    );

    sl.registerLazySingleton(() => DirectoryUtil());

    sl.registerLazySingleton(() => HiveManager(sl(), sl()));

    sl.registerLazySingleton(() => HiveEncryption(sl(), sl()));

    sl.registerLazySingleton(() => HiveStorage<SessionModel>(sl(), sl()));

    sl.registerLazySingleton(() => SessionManager(sl()));

    sl.registerLazySingleton(() => DioClient(sl(), sl()));

    sl.registerLazySingleton(() => AppConfig());
  }
}
