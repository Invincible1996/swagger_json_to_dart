import 'dart:convert';
import 'dart:io';

import 'util/file_util.dart';
import 'util/generate_service.dart';
import 'util/string_util.dart';

File file = new File('struct.dart');
Map<String, dynamic> jsonMaps = {};

var buffer = StringBuffer();

void main() async {
  buffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND\n");
  createBasicFile();
  fetchData();
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
  int code;
  String message;

  Exception exception;

  ApiResponse.completed(this.data, this.code, this.message) : status = Status.completed;

  ApiResponse.error(this.exception) : status = Status.error;
}

enum Status { completed, error }
  ''';
  FileUtil.createFile('./lib/model/api_response.dart', content);

  var controllerContent = '''
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

  ''';

  FileUtil.createFile('./lib/model/base_controller.dart', controllerContent);
}

fetchData() async {
  // http://127.0.0.1:8000/swagger/doc.json
  var client = HttpClient();
  try {
    // HttpClientRequest request = await client.get('127.0.0.1', 8000, '/swagger/doc.json');
    HttpClientRequest request = await client.get('192.168.11.41', 19960, '/v2/api-docs');
    // Optionally set up headers...
    // Optionally write to the request object...
    HttpClientResponse response = await request.close();
    // Process the response
    final stringData = await response.transform(utf8.decoder).join();
    jsonMaps = json.decode(stringData);
    generateService();
    parseJson();
  } finally {
    client.close();
  }
}

/// 生成service.dart

void generateService() async {
  // var serviceBuffer = StringBuffer();
  // serviceBuffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND\n");
  // serviceBuffer.write("import './struct.dart';\n");
  // serviceBuffer.write("import 'base_controller.dart';\n");
  // serviceBuffer.write("import 'api_response.dart';\n");
  // serviceBuffer.write("///@author\n");
  // serviceBuffer.write("///@date\n");
  // serviceBuffer.write("///@desc\n");
  // serviceBuffer.write("class UserController extends BaseController {\n");
  //
  // // 解析json 生成方法
  // jsonMaps['paths'].forEach((key, value) {
  //   // getRequest type 获取请求参数类型
  //   var request;
  //   if (value['post']['parameters'][0]['schema'] != null) {
  //     String requestRef = value['post']['parameters'][0]['schema']['\$ref'];
  //     request = requestRef.getDataTypeWithoutPrefix();
  //   }
  //   // var functionName = (key as String).getFuncName();
  //   var functionName = (value['post']['operationId'] as String).replaceAll("UsingPOST", '');
  //
  //   print(functionName);
  //
  //   var responseType = getResponseType(value);
  //   serviceBuffer.write("\t///\n");
  //   serviceBuffer.write("\t///@path $key\n");
  //   serviceBuffer.write("\t///@desc ${value['post']['summary']}\n");
  //   serviceBuffer.write("\t///\n");
  //   if (request != null) {
  //     serviceBuffer.write("\tFuture<ApiResponse<$responseType>> $functionName($request input) async {\n");
  //     serviceBuffer.write("\t\ttry{\n");
  //     serviceBuffer.write("\t\tvar res =  await post('$key', data: input.toJson());\n");
  //   } else {
  //     serviceBuffer.write("\tFuture<ApiResponse<$responseType>> $functionName() async {\n");
  //     serviceBuffer.write("\t\ttry{\n");
  //     serviceBuffer.write("\t\tvar res =  await post('$key');\n");
  //   }
  //   serviceBuffer.write("\t\tvar out = $responseType.fromJson(res.data['data']);\n");
  //   serviceBuffer.write("\t\treturn ApiResponse.completed(out,res.data['code'],res.data['message']);\n");
  //   serviceBuffer.write("\t\t}catch(e){\n");
  //   serviceBuffer.write("\t\treturn ApiResponse.error(e);\n");
  //   serviceBuffer.write("\t\t}\n");
  //   serviceBuffer.write('\t}\n\n');
  // });
  //
  // serviceBuffer.write("}");

  var content = GenerateService.generateService(jsonMaps);

  FileUtil.createFile('./lib/model/service.dart', content);
}

///
///
///
String getResponseType(value) {
  var responseType;
  Map<String, dynamic> resSchema = value['post']['responses']['200']['schema'];
  if (resSchema.containsKey('allOf')) {
    //
    responseType = (resSchema['allOf'][1]['properties']['data']['\$ref'] as String).getDataTypeWithoutPrefix();
  } else {
    //
    responseType = (resSchema['\$ref'] as String).getDataTypeWithoutPrefix().replaceCharacter();
  }
  return responseType ?? 'Null';
}

///
///
///
void parseJson() {
  var paths = jsonMaps['paths'].keys.toList();
  for (var item in paths) {
    /// 解析入参
    transferRequestToDartClass(jsonMaps['paths'][item]['post']['parameters']);

    /// 解析出参
    transferResponseToDartClass(jsonMaps['paths'][item]['post']['responses']['200']);
  }
  FileUtil.createFile('./lib/model/struct.dart', buffer.toString());
}

/// 解析返回参数生成Struct
transferResponseToDartClass(res) {
  if (res['schema']['allOf'] != null) {
    var ref2 = res['schema']['allOf'][1]['properties']['data']['\$ref'].split('/')[2];
    Map properties2 = jsonMaps['definitions'][ref2]['properties'];
    // 生成 data 实体
    var dataClassName = ref2.split('.')[1];
    transferMapToDartClass2(dataClassName, properties2);
  } else {
    // 只有一层
    var className = (res['schema']['\$ref'] as String).getDataTypeWithoutPrefix();

    Map properties = jsonMaps['definitions'][(res['schema']['\$ref'] as String).getDataTypeWithPrefix()]['properties'];

    var newClassName = '';

    if (className.contains("«string»")) {
      newClassName = className.replaceAll("«string»", '');
    } else {
      newClassName = className;
    }
    print('className====$className');
    print('className====$newClassName');

    if (!buffer.toString().contains('$newClassName')) {
      transferMapToDartClass2('$newClassName', properties);
    }
  }
}

/// 根据ref 在definitions 中获取 class 对应的Map
Map getMapByRef(String ref) {
  var className = ref.split('/')[2];
  Map properties = jsonMaps['definitions'][className]['properties'];
  return properties;
}

///
/// @desc
///
void transferMapToDartClass2(dataClassName, Map properties2) {
  buffer.write("\n\n/// @author\n");
  buffer.write("/// @date\n");
  buffer.write("/// @desc $dataClassName\n");
  buffer.write("class $dataClassName {\n");
  var refClassName;
  var mapByRef;

  var arrayClassName;
  var arrayMapRef;

  // constructor
  var csVarString = '';
  // other name constructor
  var otherCSString = '';
  // to json
  var toJsonString = '';

  properties2.forEach((key, value) {
    buffer.write("\t//\n");
    buffer.write("\t${transferType(value)} $key;\n");
    csVarString += "this.$key,";
    // 判断value 是否含有ref 属性
    // 数组
    if (value['type'] == 'array') {
      arrayClassName = (value['items']['\$ref'] as String).getDataTypeWithoutPrefix();
      arrayMapRef = getMapByRef(value['items']['\$ref']);
      otherCSString += "\n\t\tif(json['$key'] != null){\n\t\t$key = [];\n\t\tjson['$key'].forEach((v){\n\t\t\t$key.add($arrayClassName.fromJson(v));\n\t\t});\n\t}";
      toJsonString += "\n\t\tif($key !=null){\n\t\tmap['$key']=$key.map((v)=>v.toJson()).toList();\n\t\t}";
    } else if (checkMasHasRefProperty(value)) {
      refClassName = (value['\$ref'] as String).getDataTypeWithoutPrefix();
      otherCSString += "\n\t\t$key = json['$key'] != null ? $refClassName.fromJson(json['$key']) : null;";
      toJsonString += "\n\t\tif(this.$key != null){\n\t\tmap['$key'] = this.$key.toJson();\n\t\t}\n";
      mapByRef = getMapByRef(value['\$ref']);
    } else {
      otherCSString += "\n\t\t$key = json['$key'];";
      toJsonString += "\n\t\tmap['$key'] = $key;";
    }
  });

  // constructor
  buffer.write("\n\t$dataClassName({");
  buffer.write(csVarString);
  buffer.write("});");

  //other name constructor
  buffer.write("\n\t$dataClassName.fromJson(dynamic json){\n");
  buffer.write(otherCSString);
  buffer.write('\n\t}');

  // to json
  buffer.write("\n\n\tMap<String,dynamic> toJson(){");
  buffer.write("\n\tfinal map = <String, dynamic>{};");
  buffer.write(toJsonString);
  buffer.write("\n\treturn map;");
  buffer.write('\n}');
  buffer.write('\n}');

  if (arrayClassName != null) {
    transferMapToDartClass2(arrayClassName, arrayMapRef);
  }

  //
  if (refClassName != null) {
    transferMapToDartClass2(refClassName, mapByRef);
  }
}

///检查map是否含有$ref属性
bool checkMasHasRefProperty(Map map) {
  return map?.containsKey('\$ref') ?? false;
}

/// 解析请求参数生成Struct
transferRequestToDartClass(List<dynamic> params) {
  for (var item in params) {
    var desc = item['description'];
    if (item['schema'] == null) return;
    var ref = item['schema']['\$ref'].split('/')[2];
    // var className = item['schema']['\$ref'].split('.')[1];
    var className = item['schema']['\$ref'].split('/')[2];

    // 写入struct
    buffer.write("\n\n///\n");
    buffer.write("///@desc $desc\n");
    buffer.write("///\n");
    buffer.write("class $className{");

    // 从definitions获取结构体
    var properties = jsonMaps['definitions'][ref]['properties'];

    var varStringBuffer = StringBuffer();
    // fromJson String
    var fromJsonStringBuffer = StringBuffer();

    // toJson String

    var toJsonBuffer = StringBuffer();

    properties.forEach((key, value) {
      buffer.write("\n\t//${value['description']}");
      buffer.write("\n\t${capitalize(value['type'])} $key;");

      // 变量拼接
      varStringBuffer.write("this.$key,");

      //formJson
      fromJsonStringBuffer.write("\t$key = json['$key'];\n\t");

      //toJson
      toJsonBuffer.write("\tmap['$key'] = $key;\n\t");
    });

    // constructor
    buffer.write("\n\n\t$className({${varStringBuffer.toString()}");

    // fromJson

    buffer.write("});");
    buffer.write("\n\n\t");
    buffer.write("$className.fromJson(dynamic json) {");

    buffer.write("\n\t");

    buffer.write(fromJsonStringBuffer);

    buffer.write("}");

    buffer.write("\n\n\t");
    // toJson()

    buffer.write(" Map<String, dynamic> toJson() {");
    buffer.write("\n\t\t");

    buffer.write("final map = <String, dynamic>{};");

    buffer.write('\n\t');

    buffer.write(toJsonBuffer);

    buffer.write("\treturn map;");
    buffer.write("\n");
    buffer.write("\t}");
    buffer.write("\n}");
  }
}

///
///
///
Future<String> createDirectory(String dir) async {
  var directory = await Directory('$dir').create(recursive: true);
  return directory.path;
}

createFile(String content) async {
  try {
    // 向文件写入字符串
    await file.writeAsString(content);
  } catch (e) {
    print(e);
  }
}

///
String capitalize(String target) {
  return "${target[0].toUpperCase()}${target.substring(1)}";
}

/// type integer to int
String transferType(dynamic value) {
  if (value['type'] == 'string') {
    return 'String';
  } else if (value['type'] == 'integer') {
    return 'int';
  } else if (value['type'] == 'boolean') {
    return 'bool';
  } else if (value['type'] == 'array') {
    // 数组类型
    var classType = value['items']['\$ref'].split('/')[2].split('.')[1];
    return 'List<$classType>';
  } else if (checkMasHasRefProperty(value)) {
    // 如果包含ref 属性 获取实体对象
    var refData = value['\$ref'].split('/')[2].split('.')[1];
    return refData;
  } else {
    return 'dynamic';
  }
}
