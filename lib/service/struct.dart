// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateService
// **************************************************************************
///@desc Result
class Result {
  String code;
  dynamic data;
  String message;

  Result({
    this.code,
    this.data,
    this.message,
  });

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = this.code;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}

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
