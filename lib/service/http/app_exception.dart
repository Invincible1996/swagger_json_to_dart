import 'package:dio/dio.dart';

///
/// @date: 2022/1/5 18:50
/// @author: kevin
/// @description: dart
///

import 'package:dio/dio.dart';

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
