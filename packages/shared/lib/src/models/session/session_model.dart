import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@Freezed(fromJson: true, toJson: false)
abstract class SessionModel extends HiveObject with _$SessionModel {
  SessionModel._();

  factory SessionModel({
    @Default('Bearer') String tokenType,
    required String accessToken,
    DateTime? accessTokenExpiresAt,
    required String refreshToken,
    DateTime? refreshTokenExpiresAt,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) => _$SessionModelFromJson(json);
}
