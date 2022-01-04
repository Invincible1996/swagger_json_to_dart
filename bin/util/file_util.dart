import 'dart:io';

///
/// @date: 2022/1/4 11:48
/// @author: kevin
/// @description: dart
///

class FileUtil {
  ///
  /// @params [fileName] [fileContent]
  /// @desc 生成文件
  static void createFile(String fileName, String fileContent) async {
    try {
      File file = File(fileName);
      // 向文件写入字符串
      await file.writeAsString(fileContent);
    } catch (e) {
      print(e);
    }
  }
}
