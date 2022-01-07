import 'package:common_utils/common_utils.dart';

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

  GenerateStruct(this.buffer, this.jsonMaps);

  // GenerateStruct._() {
  //   buffer = StringBuffer();
  // }

  Future<String> generateStruct() async {
    buffer.write("// GENERATED CODE - DO NOT MODIFY BY HAND${'\n' * 3}");
    buffer.write(
        "// **************************************************************************\n");
    buffer.write("// GenerateStruct\n");
    buffer.write(
        "// **************************************************************************\n");

    var paths = jsonMaps['paths'].keys.toList();
    for (var item in paths) {
      /// 解析入参
      await await transferRequestToDartClass(
          jsonMaps['paths'][item]['post']['parameters']);

      /// 解析出参
      await transferResponseToDartClass(
          jsonMaps['paths'][item]['post']['responses']['200']);
    }
    return buffer.toString();
  }

  void transferMapToDartClass2(dataClassName, Map properties2) async {
    String author = await CodeFormat.getLoginUsername();
    buffer.write("\n\n///\n");
    buffer.write("/// @author $author");
    buffer.write(
        "/// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}\n");
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

    properties2.forEach((key, value) {
      buffer.write("\t//\n");
      buffer.write("\t${''.transferType(value)} $key;\n");
      csVarString += "this.$key,";
      // 判断value 是否含有ref 属性
      // 数组
      if (value['type'] == 'array') {
        arrayClassName =
            (value['items']['\$ref'] as String).getDataTypeWithoutPrefix();
        arrayMapRef = getMapByRef(value['items']['\$ref']);
        otherCSString +=
            "\n\t\tif(json['$key'] != null){\n\t\t$key = [];\n\t\tjson['$key'].forEach((v){\n\t\t\t$key.add($arrayClassName.fromJson(v));\n\t\t});\n\t}";
        toJsonString +=
            "\n\t\tif($key !=null){\n\t\tmap['$key']=$key.map((v)=>v.toJson()).toList();\n\t\t}";
      } else if (checkMasHasRefProperty(value)) {
        refClassName = (value['\$ref'] as String).getDataTypeWithoutPrefix();
        otherCSString +=
            "\n\t\t$key = json['$key'] != null ? $refClassName.fromJson(json['$key']) : null;";
        toJsonString +=
            "\n\t\tif(this.$key != null){\n\t\tmap['$key'] = this.$key.toJson();\n\t\t}\n";
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

// ///检查map是否含有$ref属性
// bool checkMasHasRefProperty(Map map) {
//   return map?.containsKey('\$ref') ?? false;
// }

  /// 解析请求参数生成Struct
  transferRequestToDartClass(List<dynamic> params) async {
    for (var item in params) {
      var desc = item['description'];
      if (item['schema'] == null) return;
      var ref = item['schema']['\$ref'].split('/')[2];
      // var className = item['schema']['\$ref'].split('.')[1];
      var className = item['schema']['\$ref'].split('/')[2];
      String author = await CodeFormat.getLoginUsername();
      // 写入struct
      buffer.write("\n\n///\n");
      buffer.write("/// @author $author");
      buffer.write(
          "/// @date ${DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd HH:MM')}\n");
      buffer.write("/// @desc $className\n");
      buffer.write("/// \n");
      buffer.write("class $className {");

      // 从definitions获取结构体
      var properties = jsonMaps['definitions'][ref]['properties'];

      var varStringBuffer = StringBuffer();
      // fromJson String
      var fromJsonStringBuffer = StringBuffer();

      // toJson String

      var toJsonBuffer = StringBuffer();

      properties.forEach((key, value) {
        buffer.write("\n\t//${value['description']}");
        buffer.write(
            "\n\t${(value['type'] as String).firstLetterUppercase()} $key;");

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

  /// 解析返回参数生成Struct
  transferResponseToDartClass(res) {
    if (res['schema']['allOf'] != null) {
      var ref2 = res['schema']['allOf'][1]['properties']['data']['\$ref']
          .split('/')[2];
      Map properties2 = jsonMaps['definitions'][ref2]['properties'];
      // 生成 data 实体
      var dataClassName = ref2.split('.')[1];
      transferMapToDartClass2(dataClassName, properties2);
    } else {
      // 只有一层
      var className =
          (res['schema']['\$ref'] as String).getDataTypeWithoutPrefix();

      Map properties = jsonMaps['definitions']
              [(res['schema']['\$ref'] as String).getDataTypeWithPrefix()]
          ['properties'];

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
}
