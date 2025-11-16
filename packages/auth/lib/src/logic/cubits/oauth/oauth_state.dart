part of 'oauth_cubit.dart';

@Freezed(fromJson: false, toJson: false)
abstract class OAuthState with _$OAuthState {
  const factory OAuthState({@Default(false) bool isLoading, @Default(null) Failure? failure}) = _OAuthState;
}
