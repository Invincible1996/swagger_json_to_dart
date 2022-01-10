// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateService
// **************************************************************************
///
/// @desc EmployeeUserNamePasswordCheckReqDTO
///
class EmployeeUserNamePasswordCheckReqDTO {
  String password;
  String userName;

  EmployeeUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });

  EmployeeUserNamePasswordCheckReqDTO.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['password'] = this.password;
    data['userName'] = this.userName;
    return data;
  }
}

///
/// @desc Result
///
class Result {
  String code;
  String data;
  String message;
  bool success;

  Result({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = this.code;
    data['data'] = this.data;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

///
/// @desc StudentUserNamePasswordCheckReqDTO
///
class StudentUserNamePasswordCheckReqDTO {
  String password;
  String userName;

  StudentUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });

  StudentUserNamePasswordCheckReqDTO.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['password'] = this.password;
    data['userName'] = this.userName;
    return data;
  }
}

///
/// @desc TeacherUserNamePasswordCheckReqDTO
///
class TeacherUserNamePasswordCheckReqDTO {
  String password;
  String userName;

  TeacherUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });

  TeacherUserNamePasswordCheckReqDTO.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['password'] = this.password;
    data['userName'] = this.userName;
    return data;
  }
}
