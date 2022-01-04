///
/// @date: 2022/1/4 13:32
/// @author: kevin
/// @description: dart

extension StringUtils on String {
  String getDataTypeWithPrefix() {
    return this.split("/")[2];
  }

  String getDataTypeWithoutPrefix() {
    return this.split("/")[2].split('.')[1];
  }

  String getFuncName() {
    var list = this.split('/');
    return list[list.length - 1];
  }
}

extension StringExtension on String {
  hello() {
    print('hello,$this');
  }
}
