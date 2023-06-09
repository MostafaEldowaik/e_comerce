
import 'package:e_comerce/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



abstract class ForgetPasswordController extends GetxController {
  checkemail();
  goToVerfiyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;

  @override
  checkemail() {}

  @override
  goToVerfiyCode() {
    if (formstate.currentState!.validate()) {
      Get.off(VerfiyCode(email: email.text));
    } else {
      print("Not Valid");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
