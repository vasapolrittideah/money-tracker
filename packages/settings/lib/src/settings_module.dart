import 'package:settings/src/data/repositories/locale_repository.dart';
import 'package:settings/src/logic/cubits/locale/locale_cubit.dart';
import 'package:shared/shared.dart';

class SettingsModule extends BaseModule {
  @override
  String get name => 'settings';

  @override
  void setupDependencies() {
    sl.registerLazySingleton<ILocaleRepository>(() => LocaleRepository(sl()));

    sl.registerFactory<LocaleCubit>(() => LocaleCubit(sl()));
  }
}
