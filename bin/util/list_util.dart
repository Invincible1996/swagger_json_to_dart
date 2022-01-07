///
/// @date: 2022/1/7 14:22
/// @author: kevin
/// @description: dart

extension ListExtension on List {
  String appendElement() {
    var buffer = StringBuffer();
    this.forEach((element) {
      buffer.write(element);
    });
    return buffer.toString();
  }
}
