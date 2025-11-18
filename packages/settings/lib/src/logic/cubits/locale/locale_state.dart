part of 'locale_cubit.dart';

@Freezed(fromJson: false, toJson: false)
abstract class LocaleState with _$LocaleState {
  const factory LocaleState({@Default(false) bool isLoading, Failure? failure, LocaleModel? locale}) = _LocaleState;
}
