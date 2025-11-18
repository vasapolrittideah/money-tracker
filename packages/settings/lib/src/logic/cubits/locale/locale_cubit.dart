import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:settings/src/data/repositories/locale_repository.dart';
import 'package:shared/shared.dart';

part 'locale_cubit.freezed.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._localeRepository) : super(const LocaleState());

  final ILocaleRepository _localeRepository;

  Future<void> loadLocale() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _localeRepository.getLocale();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (locale) => emit(state.copyWith(isLoading: false, locale: locale)),
    );
  }

  Future<void> saveLocale(LocaleModel locale) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _localeRepository.saveLocale(locale);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false, locale: locale)),
    );
  }
}
