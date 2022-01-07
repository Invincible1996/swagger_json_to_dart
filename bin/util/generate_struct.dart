import 'package:common_utils/common_utils.dart';

import 'code_format.dart';
import 'list_util.dart';
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

  // GenerateStruct._() {
  //   buffer = StringBuffer();
  // }

  Future<String> generateStruct() async {
    author = await CodeFormat.getLoginUsername();
    // buffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND${'\n' * 3}");
    // buffer.write("// **************************************************************************\n");
    // buffer.write("// GenerateStruct\n");
    // buffer.write("// **************************************************************************\n");

    var paths = jsonMaps['paths'].keys.toList();
    var buffers = StringBuffer();

    return """
    // GENERATED CODE - DO NOT MODIFY BY HAND
    // **************************************************************************
    // GenerateStruct
    // **************************************************************************
    ${_generateRequestDTO()}
    ${_generateResponseDTO()}
    """;
    for (var item in paths) {
      /// 解析入参
      buffers.write(await transferRequestToDartClass(jsonMaps['paths'][item]['post']['parameters']));

      /// 解析出参
      // await transferResponseToDartClass(jsonMaps['paths'][item]['post']['responses']['200']);
    }
    return buffers.toString();
    // return buffer.toString();
    // return """
  }

  ///
  /// 请求参数转换
  ///
  String _generateRequestDTO() {
    return (jsonMaps['paths'] as Map)
        .map((key, item) {
          var requestDTO = transferRequestToDartClass(item['post']['parameters']);
          return MapEntry(key, """
      $requestDTO
      """);
        })
        .values
        .toList()
        .appendElement();
  }

  void transferMapToDartClass2(dataClassName, Map properties) async {
    String author = await CodeFormat.getLoginUsername();
    buffer.write("\n\n///\n");
    buffer.write("/// @author $author");
    buffer.write("/// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}\n");
    buffer.write("/// @desc $dataClassName\n");
    buffer.write("/// \n");
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

    properties.forEach((key, value) {
      buffer.write("\t//\n");
      buffer.write("\t${StringUtil.transferType(value)} $key;\n");
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

  ///
  /// 返回参数生成struct
  ///
  ///
  String _generateResponseDTO() {
    return """
    
    """;
  }

  /// 解析请求参数生成Struct
  String transferRequestToDartClass(List<dynamic> params) {
    var reqList = params.map((e) {
      var ref = e['schema']['\$ref'].split('/')[2];
      var properties = jsonMaps['definitions'][ref]['properties'];
      // 从definitions获取结构体
      var className = e['schema']['\$ref'].split('/')[2];
      return """
      /// @author $author
      /// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}
      /// @desc $className
      class $className {
        ${_generateVariable(properties)}
        $className({${_generateCommonConstructor(properties)}});
        $className.fromJson(dynamic json){
        ${_generateNamedConstructor(properties)}
        }
      }
    """;
    }).toList();
    return reqList.appendElement();
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
  /// @desc 生成变量
  ///
  String _generateVariable(Map properties) {
    return properties
        .map((key, value) {
          return MapEntry(key, """
    //${value['description']};     
    ${(value['type'] as String).firstLetterUppercase()} $key;
    """);
        })
        .values
        .toList()
        .appendElement();
  }

  ///
  /// 参数构造函数
  ///
  String _generateCommonConstructor(Map properties) {
    return properties
        .map((key, value) {
          return MapEntry(key, """
    this.$key,
    """);
        })
        .values
        .toList()
        .appendElement();
  }

  ///
  /// 别名构造函数
  ///
  String _generateNamedConstructor(Map properties) {
    return properties
        .map((key, value) {
          return MapEntry(key, """
    $key = json['$key'];
    """);
        })
        .values
        .toList()
        .appendElement();
  }
}
