import 'package:e_comerce_app/core/components/alert_dialog.dart';
import 'package:e_comerce_app/core/constant/routes.dart';
import 'package:e_comerce_app/data/datasource/fire_base_remote/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/signup_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/auth/textsignup.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller = Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text(
          '17'.tr,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColor.grey,
              ),
        ),
      ),
      body: WillPopScope(
          onWillPop: alertExitApp,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                const SizedBox(height: 20),
                CustomTextTitleAuth(text: "10".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(text: "24".tr),
                const SizedBox(height: 15),
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 3, 20, "username");
                  },
                  mycontroller: controller.username,
                  hinttext: "23".tr,
                  iconData: Icons.person_outline,
                  labeltext: "20".tr,
                  // mycontroller: ,
                ),
                CustomTextFormAuth(
                  isNumber: false,

                  valid: (val) {
                    return validInput(val!, 3, 40, "email");
                  },
                  mycontroller: controller.email,
                  hinttext: "12".tr,
                  iconData: Icons.email_outlined,
                  labeltext: "18".tr,
                  // mycontroller: ,
                ),
                CustomTextFormAuth(
                  isNumber: true,
                  valid: (val) {
                    return validInput(val!, 7, 11, "phone");
                  },
                  mycontroller: controller.phone,
                  hinttext: "22".tr,
                  iconData: Icons.phone_android_outlined,
                  labeltext: "21".tr,
                  // mycontroller: ,
                ),
                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustomTextFormAuth(
                    obscureText: controller.isshowpassword,
                    onTapIcon: () {
                      controller.showPassword();
                    },
                    isNumber: false,

                    valid: (val) {
                      return validInput(val!, 3, 30, "password");
                    },
                    mycontroller: controller.password,
                    hinttext: "13".tr,
                    iconData: Icons.lock_outline,
                    labeltext: "19".tr,
                    // mycontroller: ,
                  ),
                ),
                // ================ Sigin up ============//
                controller.isSignUpOperationIsRunning
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.red,
                      ))
                    : CustomButtomAuth(
                        text: "17".tr,
                        onPressed: () {
                          controller.changeSignUpStatus();
                          controller.signUp().then(
                            (value) {
                              if (value ==
                                  UserAuthenticationStatus.isAuthenticated) {
                                Get.toNamed(AppRoute.emailVerificationScreen);
                              } else if (value ==
                                  UserAuthenticationStatus.isAuthenticatedAndEmailVerified){}else {
                                     Get.toNamed(AppRoute.homeScreen);
                                return defaultAlertDialog(
                                    context: context,
                                    alertDialogType: AlertDialogType.error,
                                    title: value);
                              }
                            },
                          );
                          controller.changeSignUpStatus();
                        },
                      ),

                // ===============================//
                const SizedBox(height: 40),
                CustomTextSignUpOrSignIn(
                  textone: "25".tr,
                  texttwo: "26".tr,
                  onTap: () {
                    controller.goToSignIn();
                  },
                ),
              ]),
            ),
          )),
    );
  }
}
