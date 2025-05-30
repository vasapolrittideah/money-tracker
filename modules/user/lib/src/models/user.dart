import 'package:core/core.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypeIds.user)
class User extends Equatable {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.verified,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String verified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['full_name'],
    email: json['email'],
    verified: json['verified'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'email': email,
    'verified': verified,
  };

  static const empty = User(id: '', fullName: '', email: '', verified: '');

  @override
  List<Object?> get props => [id, fullName, email, verified];
}
