import 'package:core/src/constants/hive_type_id.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'jwt.g.dart';

@HiveType(typeId: HiveTypeId.jwt)
final class Jwt extends Equatable {
  const Jwt({
    required this.accessToken,
    this.tokenType = 'Bearer',
    this.expiresIn = 0,
    this.refreshToken,
  });

  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String tokenType;

  @HiveField(2)
  final int expiresIn;

  @HiveField(3)
  final String? refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn, tokenType];
}
