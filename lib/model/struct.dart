// GENERATED CODE - DO NOT MODIFY BY HAND


// **************************************************************************
// GenerateStruct
// **************************************************************************


///
/// @author kevindeMacBook-Pro.local
/// @date 2022-01-05 15:42:28.328883
/// @desc EmployeeUserNamePasswordCheckReqDTO
/// 
class EmployeeUserNamePasswordCheckReqDTO {
	//密码
	String password;
	//用户账户名
	String userName;

	EmployeeUserNamePasswordCheckReqDTO({this.password,this.userName,});

	EmployeeUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
		password = json['password'];
		userName = json['userName'];
	}

	 Map<String, dynamic> toJson() {
		final map = <String, dynamic>{};
		map['password'] = password;
		map['userName'] = userName;
		return map;
	}
}

///
/// @author kevindeMacBook-Pro.local
/// @date 2022-01-05 15:42:28.330110
/// @desc Result
/// 
class Result {
	//
	String code;
	//
	String data;
	//
	String message;
	//
	bool success;

	Result({this.code,this.data,this.message,this.success,});
	Result.fromJson(dynamic json){

		code = json['code'];
		data = json['data'];
		message = json['message'];
		success = json['success'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['code'] = code;
		map['data'] = data;
		map['message'] = message;
		map['success'] = success;
	return map;
}
}

///
/// @author kevindeMacBook-Pro.local
/// @date 2022-01-05 15:42:28.330830
/// @desc StudentUserNamePasswordCheckReqDTO
/// 
class StudentUserNamePasswordCheckReqDTO {
	//密码
	String password;
	//用户账户名
	String userName;

	StudentUserNamePasswordCheckReqDTO({this.password,this.userName,});

	StudentUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
		password = json['password'];
		userName = json['userName'];
	}

	 Map<String, dynamic> toJson() {
		final map = <String, dynamic>{};
		map['password'] = password;
		map['userName'] = userName;
		return map;
	}
}

///
/// @author kevindeMacBook-Pro.local
/// @date 2022-01-05 15:42:28.330937
/// @desc TeacherUserNamePasswordCheckReqDTO
/// 
class TeacherUserNamePasswordCheckReqDTO {
	//密码
	String password;
	//用户账户名
	String userName;

	TeacherUserNamePasswordCheckReqDTO({this.password,this.userName,});

	TeacherUserNamePasswordCheckReqDTO.fromJson(dynamic json) {
		password = json['password'];
		userName = json['userName'];
	}

	 Map<String, dynamic> toJson() {
		final map = <String, dynamic>{};
		map['password'] = password;
		map['userName'] = userName;
		return map;
	}
}