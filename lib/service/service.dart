// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateService
// **************************************************************************
import './struct.dart';
import 'base_controller.dart';
import 'api_response.dart';

///@desc HelloController
class HelloController extends BaseController {
  ///
  /// @path /hello/test
  /// @desc test
  Future<dynamic> test() async {
    try {
      var res = await post(
        '/hello/test',
      );
      var out = Result.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }
}

///@desc UserController
class UserController extends BaseController {
  ///
  /// @path /user/register
  /// @desc 用户注册
  Future<dynamic> register(Person input) async {
    try {
      var res = await post('/user/register', data: input.toJson());
      var out = LoginResVO.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }

  ///
  /// @path /user/test
  /// @desc test
  Future<dynamic> test_1() async {
    try {
      var res = await post(
        '/user/test',
      );
      var out = Result.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }
}
