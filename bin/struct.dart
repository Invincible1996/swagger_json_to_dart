// GENERATED CODE - DO NOT MODIFY BY HAND


///
///@desc 请求参数
///
class LoginReq{
	//密码
	String password;
	//用户名
	String username;

	LoginReq({this.password,this.username,});

	LoginReq.fromJson(dynamic json) {
		password = json['password'];
		username = json['username'];
	}

	 Map<String, dynamic> toJson() {
		final map = <String, dynamic>{};
		map['password'] = password;
		map['username'] = username;
		return map;
	}
}

/// @author
/// @date
/// @desc LoginRes
class LoginRes {
	//
	String token;
	//
	UserDetail user_detail;
	//
	String username;

	LoginRes({this.token,this.user_detail,this.username,});
	LoginRes.fromJson(dynamic json){

		token = json['token'];
		user_detail = json['user_detail'] != null ? UserDetail.fromJson(json['user_detail']) : null;
		username = json['username'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['token'] = token;
		if(this.user_detail != null){
		map['user_detail'] = this.user_detail.toJson();
		}

		map['username'] = username;
	return map;
}
}

/// @author
/// @date
/// @desc UserDetail
class UserDetail {
	//
	String user_age;
	//
	List<UserInfo> user_info;
	//
	String user_uid;

	UserDetail({this.user_age,this.user_info,this.user_uid,});
	UserDetail.fromJson(dynamic json){

		user_age = json['user_age'];
		if(json['user_info'] != null){
		user_info = [];
		json['user_info'].forEach((v){
			user_info.add(UserInfo.fromJson(v));
		});
	}
		user_uid = json['user_uid'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['user_age'] = user_age;
		if(user_info !=null){
		map['user_info']=user_info.map((v)=>v.toJson()).toList();
		}
		map['user_uid'] = user_uid;
	return map;
}
}

/// @author
/// @date
/// @desc UserInfo
class UserInfo {
	//
	int age;
	//
	bool checked;

	UserInfo({this.age,this.checked,});
	UserInfo.fromJson(dynamic json){

		age = json['age'];
		checked = json['checked'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['age'] = age;
		map['checked'] = checked;
	return map;
}
}

///
///@desc 请求参数
///
class RegisterReq{
	//密码
	String password;
	//用户名
	String username;

	RegisterReq({this.password,this.username,});

	RegisterReq.fromJson(dynamic json) {
		password = json['password'];
		username = json['username'];
	}

	 Map<String, dynamic> toJson() {
		final map = <String, dynamic>{};
		map['password'] = password;
		map['username'] = username;
		return map;
	}
}

/// @author
/// @date
/// @desc RegisterRes
class RegisterRes {
	//
	String password;
	//
	String username;

	RegisterRes({this.password,this.username,});
	RegisterRes.fromJson(dynamic json){

		password = json['password'];
		username = json['username'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['password'] = password;
		map['username'] = username;
	return map;
}
}

/// @author
/// @date
/// @desc Response
class Response {
	//
	int code;
	//
	dynamic data;
	//
	String msg;

	Response({this.code,this.data,this.msg,});
	Response.fromJson(dynamic json){

		code = json['code'];
		data = json['data'];
		msg = json['msg'];
	}

	Map<String,dynamic> toJson(){
	final map = <String, dynamic>{};
		map['code'] = code;
		map['data'] = data;
		map['msg'] = msg;
	return map;
}
}