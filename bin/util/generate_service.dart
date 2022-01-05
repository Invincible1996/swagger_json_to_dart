///
/// @date: 2022/1/5 13:36
/// @author: kevin
/// @description: 生成service 文件
///
import 'string_util.dart';
import 'dart:io' show Platform;

class GenerateService {
  ///
  ///
  ///
  static String generateService(jsonMaps) {
    var serviceBuffer = StringBuffer();
    serviceBuffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND\n");
    serviceBuffer.write("import './struct.dart';\n");
    serviceBuffer.write("import 'base_controller.dart';\n");
    serviceBuffer.write("import 'api_response.dart';\n");
    serviceBuffer.write(
        "// **************************************************************************\n");
    serviceBuffer.write("// GenerateService\n");
    serviceBuffer.write(
        "// **************************************************************************\n\n");
    // 解析json 生成方法
    jsonMaps['paths'].forEach((key, value) {
      serviceBuffer.write("/// @author ${Platform.localHostname} \n");
      serviceBuffer.write("/// @date ${DateTime.now()}\n");
      var className = (value['post']['tags'][0] as String).replaceLine();
      serviceBuffer.write("/// @desc $className");
      serviceBuffer.write("\nclass $className extends BaseController {\n");
      // getRequest type 获取请求参数类型
      var request;
      if (value['post']['parameters'][0]['schema'] != null) {
        String requestRef = value['post']['parameters'][0]['schema']['\$ref'];
        request = requestRef.getDataTypeWithoutPrefix();
      }
      // var functionName = (key as String).getFuncName();
      var functionName =
          (value['post']['operationId'] as String).replaceAll("UsingPOST", '');

      var responseType = ''.getResponseType(value);
      serviceBuffer.write("\t///\n");
      serviceBuffer.write("\t///@path $key\n");
      serviceBuffer.write("\t///@desc ${value['post']['summary']}\n");
      serviceBuffer.write("\t///\n");
      if (request != null) {
        serviceBuffer.write(
            "\tFuture<ApiResponse<$responseType>> $functionName($request input) async {\n");
        serviceBuffer.write("\t\ttry {\n");
        serviceBuffer.write(
            "\t\t\tvar res =  await post('$key', data: input.toJson());\n");
      } else {
        serviceBuffer.write(
            "\tFuture<ApiResponse<$responseType>> $functionName() async {\n");
        serviceBuffer.write("\t\ttry {\n");
        serviceBuffer.write("\t\tvar res =  await post('$key');\n");
      }
      serviceBuffer.write(
          "${'\t' * 3}var out = $responseType.fromJson(res.data['data']);\n");
      serviceBuffer.write(
          "${'\t' * 3}return ApiResponse.completed(out,res.data['code'],res.data['message']);\n");
      serviceBuffer.write("\t\t} catch(e) {\n");
      serviceBuffer.write("${'\t' * 3}return ApiResponse.error(e);\n");
      serviceBuffer.write("\t\t}\n");
      serviceBuffer.write('\t}\n');
      serviceBuffer.write("}\n");
    });

    return serviceBuffer.toString();
  }
}
