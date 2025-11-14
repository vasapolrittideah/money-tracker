import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(fromJson: true, toJson: false)
abstract class ApiResponse with _$ApiResponse {
  factory ApiResponse({Map<String, dynamic>? data, ApiError? error, required DateTime timestamp}) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
}

@Freezed(fromJson: true, toJson: false)
abstract class ApiError with _$ApiError {
  factory ApiError({required String code, required String message, List<ApiValidationError>? details}) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
}

@Freezed(fromJson: true, toJson: false)
abstract class ApiValidationError with _$ApiValidationError {
  factory ApiValidationError({required String field, required String message, required dynamic value}) =
      _ApiValidationError;

  factory ApiValidationError.fromJson(Map<String, dynamic> json) => _$ApiValidationErrorFromJson(json);
}
