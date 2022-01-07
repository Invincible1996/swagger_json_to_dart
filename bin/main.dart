import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'util/code_format.dart';
import 'util/file_util.dart';
import 'util/generate_service.dart';
import 'util/generate_struct.dart';

Map<String, dynamic> jsonMaps = {};

var buffer = StringBuffer();

void main() async {
  // get console input
  print('请输入swagger json url（不输入选择默认地址）');
  var defaultUrl = 'http://192.168.11.41:19960/v2/api-docs';
  var requestUrl = stdin.readLineSync(encoding: utf8);
  print(requestUrl);
  createBasicFile();
  fetchData(requestUrl.length > 0 ? requestUrl : defaultUrl);
}

createBasicFile() {
  //ApiResponse
  var content = '''
  ///
/// @date: 2021/12/20 14:39
/// @author: kevin
/// @description: dart
class ApiResponse<T> implements Exception {
  Status status;
  T data;
  String code;
  String message;

  Exception exception;

  ApiResponse.completed(this.data, this.code, this.message) : status = Status.completed;

  ApiResponse.error(this.exception) : status = Status.error;
}

enum Status { completed, error }
  ''';

  FileUtil.createFile('api_response.dart', content);

  var controllerContent = '''
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
    dio.options.baseUrl = 'http://192.168.11.41:19960';
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

  ''';

  FileUtil.createFile('base_controller.dart', controllerContent);
}

fetchData(String requestUrl) async {
  // http://127.0.0.1:8000/swagger/doc.json
  // http://192.168.11.41:19960/v2/api-docs
  var client = HttpClient();
  try {
    // HttpClientRequest request = await client.get('127.0.0.1', 8000, '/swagger/doc.json');
    // HttpClientRequest request = await client.get('192.168.11.41', 19960, '/v2/api-docs');
    // Optionally set up headers...
    // Optionally write to the request object...
    // HttpClientResponse response = await request.close();
    // Process the response

    Dio dio = Dio();
    var response = await dio.get(requestUrl);
    print(response);

    // final stringData = await response.transform(utf8.decoder).join();
    jsonMaps = response.data;
    generateService();
    generateStruct();
  } finally {
    client.close();
    CodeFormat.formatCode();
  }
}

/// 生成service.dart
void generateService() async {
  var content = await GenerateService.generateService(jsonMaps);
  print(content);
  FileUtil.createFile('service.dart', content);
}

void generateStruct() async {
  var struct = GenerateStruct(buffer, jsonMaps);
  var content = await struct.generateStruct();
  FileUtil.createFile('struct.dart', content);
}
