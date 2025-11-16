import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({required String email, required String password}) = _RegisterRequest;
}
