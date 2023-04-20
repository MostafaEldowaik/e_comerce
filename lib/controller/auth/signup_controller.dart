import 'package:e_comerce/data/datasource/fire_base_remote/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
} 

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  //===============================================//
  bool isSignUpOperationIsRunning = false;
  changeSignUpStatus() {
    isSignUpOperationIsRunning = !isSignUpOperationIsRunning ;
    update();
  }
  //==============================================//
  UserCredential? userCredential;

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  Future<String> signUp() async {
    FormState? formdata = formstate.currentState;

    String returnedstatusOrError = await FireBaseAuthDataSource.signUp(
        formdata: formdata,
        userCredential: userCredential,
        email: email.text.trim(),
        password: password.text.trim(),
        phone: phone.text.trim(),
        userName: username.text);
    print(returnedstatusOrError);
    return returnedstatusOrError;
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
