  ///
/// @date: 2021/12/20 14:39
/// @author: kevin
/// @description: dart
class ApiResponse<T> implements Exception {
  Status status;
  T data;
  int code;
  String message;

  Exception exception;

  ApiResponse.completed(this.data, this.code, this.message) : status = Status.completed;

  ApiResponse.error(this.exception) : status = Status.error;
}

enum Status { completed, error }
  