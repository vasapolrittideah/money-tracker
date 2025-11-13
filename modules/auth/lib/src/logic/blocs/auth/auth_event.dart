part of 'auth_bloc.dart';

@Freezed(fromJson: false, toJson: false)
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.subscriptionRequested() = AuthSubscriptionRequested;
}
