import 'package:core/core.dart';

class SignInRequest extends Equatable {
  const SignInRequest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  @override
  List<Object?> get props => [email, password];
}
