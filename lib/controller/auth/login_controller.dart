import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constant/routes.dart';
import '../../data/datasource/fire_base_remote/firebase_auth.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // firebase by manhey
  UserCredential? userCredential;

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  Future<String> login() async {
    FormState? formdata = formstate.currentState;

    String returnedstatusOrError = await FireBaseAuthDataSource.login(
        formdata: formdata,
        userCredential: userCredential,
        email: email.text.trim(),
        password: password.text.trim());
    /// print(returnedstatusOrError);

    return returnedstatusOrError;
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}

