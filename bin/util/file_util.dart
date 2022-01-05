import 'dart:io';

///
/// @date: 2022/1/4 11:48
/// @author: kevin
/// @description: dart
///

class FileUtil {
  ///
  /// @params [fileName]
  /// @params [fileContent]
  /// @desc 生成文件
  static void createFile(String fileName, String fileContent) async {
    try {
      var directory = await Directory('lib/service/').create(recursive: true);
      File file = File('${directory.path}$fileName');
      print('文件生成的路径 ${directory.path}$fileName');
      await file.writeAsString(fileContent);
    } catch (e) {
      print(e);
    }
  }
}
