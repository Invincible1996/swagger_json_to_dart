// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateService
// **************************************************************************
import './struct.dart';
import 'base_controller.dart';
import 'api_response.dart';

///@desc StudentAccountController
class StudentAccountController extends BaseController {
  ///
  /// @path /studentAccount/checkUserNameAndPassword
  /// @desc 学生账户名密码登录
  Future<dynamic> checkUserNameAndPassword_1(
      StudentUserNamePasswordCheckReqDTO input) async {
    try {
      var res = await post('/studentAccount/checkUserNameAndPassword',
          data: input.toJson());
      var out = Result.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }
}

///@desc TeacherAccountController
class TeacherAccountController extends BaseController {
  ///
  /// @path /teacherAccount/checkUserNameAndPassword
  /// @desc 老师用户名密码校验
  Future<dynamic> checkUserNameAndPassword_2(
      TeacherUserNamePasswordCheckReqDTO input) async {
    try {
      var res = await post('/teacherAccount/checkUserNameAndPassword',
          data: input.toJson());
      var out = Result.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }
}

///@desc EmployeeAccountController
class EmployeeAccountController extends BaseController {
  ///
  /// @path /employeeAccount/checkUserNameAndPassword
  /// @desc 员工用户名密码校验
  Future<dynamic> checkUserNameAndPassword(
      EmployeeUserNamePasswordCheckReqDTO input) async {
    try {
      var res = await post('/employeeAccount/checkUserNameAndPassword',
          data: input.toJson());
      var out = Result.fromJson(res.data['data']);
      return ApiResponse.completed(out, res.data['code'], res.data['message']);
    } catch (err) {
      return ApiResponse.error(err);
    }
  }
}
