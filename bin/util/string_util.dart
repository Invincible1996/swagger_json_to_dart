///
/// @date: 2022/1/4 13:32
/// @author: kevin
/// @description: dart

extension StringUtils on String {
  String getDataTypeWithPrefix() {
    return this.split("/")[2];
  }

  ///
  /// @desc 获取实体类类型
  ///
  String getDataTypeWithoutPrefix() {
    // return this.split("/")[2].split('.')[1];
    return this.split("/")[2];
  }

  ///
  ///@desc 获取方法名称
  ///
  String getFuncName() {
    var list = this.split('/');
    return list[list.length - 1];
  }

  ///
  /// @desc 替换指定字符串 «string»
  ///
  String replaceCharacter() {
    return this.replaceAll("«string»", '');
  }

  ///
  /// @desc 首字母大写
  ///
  String firstLetterUppercase() {
    return '${this.substring(0, 1).toUpperCase()}${this.substring(1)}';
  }

  ///
  /// @desc 下划线替换并大些
  ///
  String replaceLine() {
    if (this.contains("-")) {
      var list = this.split('-');
      var newList = list
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              value.firstLetterUppercase(),
            ),
          )
          .values
          .toList();
      var str = '';
      newList.forEach((element) {
        str += element;
      });
      return str;
    } else {
      return this;
    }
  }

  ///
  /// @desc 下划线替换并大些
  ///
  String replaceUnderLine() {
    if (this.contains("_")) {
      var list = this.split('_');
      var newList = list
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              key != 0 ? value.firstLetterUppercase() : value,
            ),
          )
          .values
          .toList();
      var str = '';
      newList.forEach((element) {
        str += element;
      });
      return str;
    } else {
      return this;
    }
  }

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
}

///检查map是否含有$ref属性
bool checkMasHasRefProperty(Map map) {
  return map?.containsKey('\$ref') ?? false;
}
