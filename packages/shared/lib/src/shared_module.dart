import 'package:shared/libs.dart';
import 'package:shared/shared.dart';

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

    sl.registerLazySingleton(() => HiveStorage<LocaleModel>(sl(), sl()));

    sl.registerLazySingleton(() => SessionManager(sl()));

    sl.registerLazySingleton(() => DioClient(sl(), sl()));

    sl.registerLazySingleton(() => AppConfig());
  }
}
