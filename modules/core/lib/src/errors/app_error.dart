import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  const AppError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerError extends AppError {
  const ServerError({super.message});
}

class CacheError extends AppError {
  const CacheError({super.message});
}

class NetworkError extends AppError {
  const NetworkError({super.message});
}

class CanceledError extends AppError {
  const CanceledError({super.message});
}

class TimeoutError extends AppError {
  const TimeoutError({super.message});
}

class UnknownError extends AppError {
  const UnknownError({super.message});
}
