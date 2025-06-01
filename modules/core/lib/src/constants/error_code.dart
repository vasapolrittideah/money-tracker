// This ErrorCode class is reference to grpc error code
class ErrorCode {
  static const int ok = 0;
  static const int canceled = 1;
  static const int unknown = 2;
  static const int invalidArgument = 3;
  static const int deadlineExceeded = 4;
  static const int notFound = 5;
  static const int alreadyExists = 6;
  static const int permissionDenied = 7;
  static const int resourceExhausted = 8;
  static const int failedPrecondition = 9;
  static const int aborted = 10;
  static const int outOfRange = 11;
  static const int unimplemented = 12;
  static const int internal = 13;
  static const int unavailable = 14;
  static const int dataLoss = 15;
  static const int unauthenticated = 16;
}
