// GENERATED CODE - DO NOT MODIFY BY HAND


///
///@desc req
///
class EmployeeUserNamePasswordCheckReqDTO{
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

/// @author
/// @date
/// @desc Result
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
///@desc req
///
class StudentUserNamePasswordCheckReqDTO{
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
///@desc req
///
class TeacherUserNamePasswordCheckReqDTO{
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