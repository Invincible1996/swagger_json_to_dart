  import 'package:dio/dio.dart';

///
/// @date: 2022/1/4 15:57
/// @author: kevin
/// @description: dart
///

class BaseController {
  Dio dio = Dio();

  BaseController() {
    dio.options.baseUrl = 'http://127.0.0.1:8000';
  }

  Future post(String path, {data}) async {
    return await dio.post(path, data: data);
  }

  get() {}
}

  