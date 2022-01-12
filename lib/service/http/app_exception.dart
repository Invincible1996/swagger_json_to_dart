///
///
///
class AppException implements Exception {
  final int code;
  final String message;

  AppException([this.code, this.message]);

  @override
  String toString() {
    return super.toString();
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([int code, String message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([int code, String message]) : super(code, message);
}
