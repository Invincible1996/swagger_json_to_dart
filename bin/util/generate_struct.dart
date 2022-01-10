import 'code_format.dart';

///
/// @date: 2022/1/5 13:37
/// @author: kevin
/// @description: 生成struct 文件
///
import 'string_util.dart';

class GenerateStruct {
  StringBuffer buffer;
  Map jsonMaps;
  String author = '';

  GenerateStruct(this.buffer, this.jsonMaps);

  Future<String> generateStruct() async {
    author = await CodeFormat.getLoginUsername();
    return """
            // GENERATED CODE - DO NOT MODIFY BY HAND
      // **************************************************************************
      // GenerateService
      // **************************************************************************
      ${_generateDartStruct()}
      """;
  }

  ///
  /// @desc definitions to dart class
  ///
  String _generateDartStruct() {
    var str = '';
    (jsonMaps['definitions'] as Map).forEach((key, value) {
      print(key);
      var className = (key as String).replaceClassName();
      str += """
      ///
      /// @desc $className
      ///
      class $className {
        ${_generateVariableStr(value['properties'])}
        $className ({${_generateConstructStr(value['properties'])}});
        
        $className.fromJson(Map<String, dynamic> json) {
        ${_generateNamedConstructorStr(value['properties'])}
        }
        
        Map<String,dynamic> toJson(){
        final Map<String,dynamic> data = {};
        ${_generateToJsonFunc(value['properties'])}
          return data;
          }
        }
      """;
    });
    return str;
  }

  ///
  ///
  ///
  String _generateConstructStr(Map properties) {
    var str = '';
    properties.forEach((key, value) {
      str += """
      this.$key,
      """;
    });
    return str;
  }

  ///
  /// 生成变量声明代码
  ///
  String _generateVariableStr(Map properties) {
    var str = '';
    properties.forEach((key, value) {
      return str += """
        ${StringUtil.transferType(value)} $key;
    """;
    });
    return str;
  }

  ///
  ///生成别名构造函数
  ///
  String _generateNamedConstructorStr(Map properties) {
    var str = '';
    properties.forEach((key, value) {
      str += """ ${_generateNamedStr(key, value)}""";
    });
    return str;
  }

  _generateNamedStr(key, value) {
    if (value.containsKey('\$ref')) {
      return "$key = json['$key'] != null?${(value['\$ref'] as String).getDataTypeFromRef()}.fromJson(json['$key']): null;";
    } else {
      if (value['type'] == 'array') {
        var listType = (value['items']['\$ref'] as String).getDataTypeFromRef();
        return """
        if(json['$key'] != null){
        $key = <$listType>[];
        json['$key'].forEach((v){
            $key.add($listType.fromJson(v));
          });
        }
        """;
      } else {
        return "$key = json['$key'];";
      }
    }
  }

  ///
  /// @desc toJson
  ///
  String _generateToJsonFunc(Map properties) {
    var str = '';
    properties.forEach((key, value) {
      str += """
      ${_generateToJsonVariable(key, value)}""";
    });
    return str;
  }

  ///
  ///
  ///
  String _generateToJsonVariable(key, value) {
    if (value.containsKey('\$ref')) {
      return """
      if (this.$key != null){
      data['$key'] = this.$key.toJson();
      }
      """;
    } else {
      if (value['type'] == 'array') {
        return """
        if(this.$key != null){
        data['$key'] = this.$key.map((v)=>v.toJson()).toList();
        }""";
      } else {
        return "data['$key'] = this.$key;";
      }
    }
  }
}
