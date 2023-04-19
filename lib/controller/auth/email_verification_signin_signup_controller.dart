import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class EmailVerificationController extends GetxController {}

class EmailVerificationControllerImp extends EmailVerificationController {
  RxBool isEmailVerified = false.obs;
  Timer? timer;

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified.value) {
      timer?.cancel();
      return true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
