import 'package:common_utils/common_utils.dart';

import 'code_format.dart';
import 'list_util.dart';

///
/// @date: 2022/1/5 13:36
/// @author: kevin
/// @description: 生成service 文件
///
import 'string_util.dart';

class GenerateService {
  ///
  ///
  ///
  static Future<String> generateService(jsonMaps) async {
    // String author = await CodeFormat.getLoginUsername();
    // var serviceBuffer = StringBuffer();
    // serviceBuffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND\n");
    // serviceBuffer.write("import './struct.dart';\n");
    // serviceBuffer.write("import 'base_controller.dart';\n");
    // serviceBuffer.write("import 'api_response.dart';\n");
    // serviceBuffer.write(
    //     "// **************************************************************************\n");
    // serviceBuffer.write("// GenerateService\n");
    // serviceBuffer.write(
    //     "// **************************************************************************\n\n");
    // // 解析json 生成方法
    // jsonMaps['paths'].forEach((key, value) async {
    //   serviceBuffer.write("/// @author $author");
    //   serviceBuffer.write(
    //       "/// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}\n");
    //   var className = (value['post']['tags'][0] as String).replaceLine();
    //   serviceBuffer.write("/// @desc $className");
    //   serviceBuffer.write("\nclass $className extends BaseController {\n");
    //   // getRequest type 获取请求参数类型
    //   var request;
    //   if (value['post']['parameters'][0]['schema'] != null) {
    //     String requestRef = value['post']['parameters'][0]['schema']['\$ref'];
    //     request = requestRef.getDataTypeWithoutPrefix();
    //   }
    //   // var functionName = (key as String).getFuncName();
    //   var functionName =
    //       (value['post']['operationId'] as String).replaceAll("UsingPOST", '');
    //
    //   var responseType = ''.getResponseType(value);
    //   serviceBuffer.write("\t///\n");
    //   serviceBuffer.write("\t///@path $key\n");
    //   serviceBuffer.write("\t///@desc ${value['post']['summary']}\n");
    //   serviceBuffer.write("\t///\n");
    //   if (request != null) {
    //     serviceBuffer.write(
    //         "\tFuture<ApiResponse<$responseType>> $functionName($request input) async {\n");
    //     serviceBuffer.write("\t\ttry {\n");
    //     serviceBuffer.write(
    //         "\t\t\tvar res =  await post('$key', data: input.toJson());\n");
    //   } else {
    //     serviceBuffer.write(
    //         "\tFuture<ApiResponse<$responseType>> $functionName() async {\n");
    //     serviceBuffer.write("\t\ttry {\n");
    //     serviceBuffer.write("\t\tvar res =  await post('$key');\n");
    //   }
    //   serviceBuffer
    //       .write("${'\t' * 3}var out = $responseType.fromJson(res.data);\n");
    //   serviceBuffer.write(
    //       "${'\t' * 3}return ApiResponse.completed(out,res.data['code'],res.data['message']);\n");
    //   serviceBuffer.write("\t\t} catch(e) {\n");
    //   serviceBuffer.write("${'\t' * 3}return ApiResponse.error(e);\n");
    //   serviceBuffer.write("\t\t}\n");
    //   serviceBuffer.write('\t}\n');
    //   serviceBuffer.write("}\n");

    // 使用代码模板
    // });
    return """
      // GENERATED CODE - DO NOT MODIFY BY HAND
      // **************************************************************************
      // GenerateService
      // **************************************************************************
        import './struct.dart';
        import 'base_controller.dart';
        import 'api_response.dart';
        ${await _generateClass(jsonMaps)}
      """;
    // return serviceBuffer.toString();
  }

  ///
  ///
  ///
  ///
  static Future<String> _generateClass(Map jsonMaps) async {
    String author = await CodeFormat.getLoginUsername();
    var list = (jsonMaps['paths'] as Map)
        .map(
          (key, value) {
            var className = (value['post']['tags'][0] as String).replaceLine();
            var functionName = (value['post']['operationId'] as String)
                .replaceAll("UsingPOST", '');
            var responseType = ''.getResponseType(value);
            var request;
            if (value['post']['parameters'][0]['schema'] != null) {
              String requestRef =
                  value['post']['parameters'][0]['schema']['\$ref'];
              request = requestRef.getDataTypeWithoutPrefix();
            }
            return MapEntry(key, """
          /// @author $author
          /// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}
          /// @desc $className
          class $className extends BaseController {
            /// @path $key
            /// @desc ${value['post']['summary']}
            Future<ApiResponse<$responseType>> $functionName(${request != null ? '$request input' : ''}) async {
                try {
                var res = await post('$key',data:${request != null ? 'input.toJson()' : ''});
                var out = $responseType.fromJson(res.data);
                return ApiResponse.completed(out,res.data['code'],res.data['message']);
                } catch(err) {
                  return ApiResponse.error(err);
                }            
            }
          }
          """);
          },
        )
        .values
        .toList();

    return list.appendElement();
  }
}
