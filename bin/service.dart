// GENERATED CODE - DO NOT MODIFY BY HAND
import './struct.dart';
import 'base_controller.dart';
///@author
///@date
///@desc
class UserController extends BaseController {
	///@path /api/v1/login
	///@desc 登录
	Future<LoginRes> login(LoginReq input) async {
	var res =  await post('/api/v1/login', data: input.toJson());
	var out = LoginRes.fromJson(res.data);
	return out;
	}

	///@path /api/v1/register
	///@desc 注册
	Future<RegisterRes> register(RegisterReq input) async {
	var res =  await post('/api/v1/register', data: input.toJson());
	var out = RegisterRes.fromJson(res.data);
	return out;
	}

	///@path /api/v1/users
	///@desc 获取用户列表
	Future<Response> users() async {
	var res =  await post('/api/v1/users');
	var out = Response.fromJson(res.data);
	return out;
	}

}