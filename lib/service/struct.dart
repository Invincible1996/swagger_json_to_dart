// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateStruct
// **************************************************************************
/// @author kevin

/// @date 2022-01-07 17:01
/// @desc EmployeeUserNamePasswordCheckReqDTO
class EmployeeUserNamePasswordCheckReqDTO {
  //密码;
  String password;
  //用户账户名;
  String userName;

  EmployeeUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });
  EmployeeUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
    password = json['password'];
    userName = json['userName'];
  }
}

/// @author kevin

/// @date 2022-01-07 17:01
/// @desc StudentUserNamePasswordCheckReqDTO
class StudentUserNamePasswordCheckReqDTO {
  //密码;
  String password;
  //用户账户名;
  String userName;

  StudentUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });
  StudentUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
    password = json['password'];
    userName = json['userName'];
  }
}

/// @author kevin

/// @date 2022-01-07 17:01
/// @desc TeacherUserNamePasswordCheckReqDTO
class TeacherUserNamePasswordCheckReqDTO {
  //密码;
  String password;
  //用户账户名;
  String userName;

  TeacherUserNamePasswordCheckReqDTO({
    this.password,
    this.userName,
  });
  TeacherUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
    password = json['password'];
    userName = json['userName'];
  }
}
