// GENERATED CODE - DO NOT MODIFY BY HAND
import './struct.dart';
import 'base_controller.dart';
import 'api_response.dart';
///@author
///@date
///@desc
class UserController extends BaseController {
	///
	///@path /api/v1/login
	///@desc 登录
	///
	Future<ApiResponse<LoginRes>> login(LoginReq input) async {
		try{
		var res =  await post('/api/v1/login', data: input.toJson());
		var out = LoginRes.fromJson(res.data['data']);
		return ApiResponse.completed(out,res.data['code'],res.data['message']);
		}catch(e){
		return ApiResponse.error(e);
		}
	}

	///
	///@path /api/v1/register
	///@desc 注册
	///
	Future<ApiResponse<RegisterRes>> register(RegisterReq input) async {
		try{
		var res =  await post('/api/v1/register', data: input.toJson());
		var out = RegisterRes.fromJson(res.data['data']);
		return ApiResponse.completed(out,res.data['code'],res.data['message']);
		}catch(e){
		return ApiResponse.error(e);
		}
	}

	///
	///@path /api/v1/users
	///@desc 获取用户列表
	///
	Future<ApiResponse<Response>> users() async {
		try{
		var res =  await post('/api/v1/users');
		var out = Response.fromJson(res.data['data']);
		return ApiResponse.completed(out,res.data['code'],res.data['message']);
		}catch(e){
		return ApiResponse.error(e);
		}
	}

}