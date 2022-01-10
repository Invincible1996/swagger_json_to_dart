import 'package:swagger_json_to_dart/service/service.dart';
import 'package:swagger_json_to_dart/service/struct.dart';

void main(List<String> args) async {
  // var response = await EmployeeAccountController().checkUserNameAndPassword(
  //   EmployeeUserNamePasswordCheckReqDTO(
  //     userName: '',
  //     password: '',
  //   ),
  // );

  var response = await UserController().register(Person());

  print(response);
}
