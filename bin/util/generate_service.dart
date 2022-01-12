///
/// @date: 2022/1/5 13:36
/// @author: kevin
/// @description: 生成service 文件
///
import 'string_util.dart';

class GenerateService {
  Map jsonMaps;

  GenerateService(jsonMaps) {
    this.jsonMaps = _formatJson(jsonMaps);
  }

  ///
  ///
  ///
  Future<String> generateService() async {
    // _formatJson();

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
        ${await _generateClass()}
      """;
    // return serviceBuffer.toString();
  }

  ///
  ///
  /// @ json结构变换
  ///
  _formatJson(jsonMaps) {
    Map<String, List> tagMaps = {};
    for (var value in (jsonMaps['tags'] as List)) {
      tagMaps.putIfAbsent(value['name'], () => []);
    }
    (jsonMaps['paths'] as Map).forEach((key, value) {
      tagMaps.forEach((key2, value2) {
        if (key2 == value['post']['tags'][0]) {
          value2.add({key: value});
        }
      });
    });
    return tagMaps;
  }

  ///
  ///
  ///
  _generateClass() {
    var service = '';
    jsonMaps.forEach((key, value) {
      var className = (key as String).getClassNameFromTags();
      service += """
      ///@desc $className
      class $className extends BaseController{
        ${_generateFunc(value)}
      }
      """;
    });
    return service;
  }

  String _generateFunc(List values) {
    var str = '';
    values.forEach((element) {
      (element as Map).forEach((key, value) {
        var request;
        if (value['post']['parameters'] != null &&
            value['post']['parameters'][0]['schema'] != null) {
          String requestRef = value['post']['parameters'][0]['schema']['\$ref'];
          request = requestRef.getDataTypeWithoutPrefix();
        }
        var responseType = ''.getResponseType(value);
        str += """
      ///
      /// @path $key
      /// @desc ${value['post']['summary']}
      Future<dynamic> ${value['post']['operationId'].replaceAll("UsingPOST", '')}(${request != null ? '$request input' : ''}) async {
        try {
                var res = await post('$key',${request != null ? 'data: input.toJson()' : ''});
                var out = $responseType.fromJson(res.data['data']);
                return ApiResponse.completed(out,res.data['code'],res.data['message']);
                } catch(err) {
                  return ApiResponse.error(err);
                }
      }
      """;
      });
    });
    return str;
  }
}
