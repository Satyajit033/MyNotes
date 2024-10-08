import 'package:get/get.dart';
import 'package:my_notes/data/utility/auth_utility.dart';
import 'package:my_notes/data/models/login_model.dart';
import 'package:my_notes/data/services/network_caller.dart';
import 'package:my_notes/data/models/network_response.dart';
import 'package:my_notes/data/utility/urls.dart';


class LoginController extends GetxController {
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      return true;
    } else {
      return false;
    }
  }
}