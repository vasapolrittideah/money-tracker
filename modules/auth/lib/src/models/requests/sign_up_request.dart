import 'package:core/core.dart';

class SignUpRequest extends Equatable {
  const SignUpRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'email': email,
    'password': password,
  };

  @override
  List<Object?> get props => [fullName, email, password];
}
