import 'dart:io';

///
/// @date: 2022/1/5 16:57
/// @author: kevin
/// @description: dart
///
///

class CodeFormat {
  static formatCode() async {
    var result = await Process.run('flutter', ['format', '.']);
  }

  static Future<String> getLoginUsername() async {
    var result = await Process.run('id', ['-un']);
    print(result.stdout);
    return result.stdout;
  }
}
