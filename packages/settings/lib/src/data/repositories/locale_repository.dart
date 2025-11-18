import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract class ILocaleRepository {
  Future<Either<Failure, LocaleModel>> getLocale();
  Future<Either<Failure, Unit>> saveLocale(LocaleModel locale);
}

class LocaleRepository implements ILocaleRepository {
  LocaleRepository(this._hiveStorage);

  final HiveStorage<LocaleModel> _hiveStorage;

  final String _localeKey = 'locale';

  @override
  Future<Either<Failure, LocaleModel>> getLocale() => ErrorHandler.handle(() async {
    final locale = await _hiveStorage.getItem(_localeKey);

    if (locale == null) {
      return LocaleModel(languageCode: 'th');
    }

    return locale;
  });

  @override
  Future<Either<Failure, Unit>> saveLocale(LocaleModel locale) => ErrorHandler.handle(() async {
    await _hiveStorage.storeItem(_localeKey, locale);
    return unit;
  });
}
