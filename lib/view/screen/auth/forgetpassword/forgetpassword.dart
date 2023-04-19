
import 'package:e_comerce_app/controller/auth/forgetpassword_controller.dart';
import 'package:e_comerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('14'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: controller.formstate,
          child: ListView(children: [
            const SizedBox(height: 20),
            CustomTextTitleAuth(text: "27".tr),
            const SizedBox(height: 10),
            CustomTextBodyAuth(
                // please Enter Your Email Address To Recive A verification code
                text: "29".tr),
            const SizedBox(height: 15),
            CustomTextFormAuth(
              isNumber: false,
              valid: (val) {
                return validInput(val!, 3, 100, "email");
              },
              mycontroller: controller.email,
              hinttext: "12".tr,
              iconData: Icons.email_outlined,
              labeltext: "18".tr,
              // mycontroller: ,
            ),
            CustomButtomAuth(
                text: "30".tr,
                onPressed: () {
                  controller.goToVerfiyCode();
                }),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
