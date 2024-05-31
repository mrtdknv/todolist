import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends GetxController {
  // ignore: prefer_final_fields
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;
  void clear() {
    _userModel.value = UserModel();
  }
}
