import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///
/// @date: 2022/1/4 15:57
/// @author: kevin
/// @description: dart
///

class BaseController {
  Dio dio = Dio();

  BaseController() {
    dio.options.baseUrl = 'http://127.0.0.1:8090/cn';
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future post(String path, {data}) async {
    return await dio.post(path, data: data);
  }

  get() {}
}
