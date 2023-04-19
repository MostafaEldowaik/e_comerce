import 'package:e_comerce_app/controller/auth/email_verification_signin_signup_controller.dart';
import 'package:e_comerce_app/core/constant/routes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailVerificationControllerImp controller =
        Get.put(EmailVerificationControllerImp());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email on  ${FirebaseAuth.instance.currentUser?.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => controller.isEmailVerified.value
                  ? const Text("Email is verified")
                  : const Center(child: CircularProgressIndicator())),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Obx(
                () => controller.isEmailVerified.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          child: const Text('go to signup success'),
                          onPressed: () {
                            Get.toNamed(AppRoute.successSignUp);
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          child: const Text('Resend'),
                          onPressed: () {
                            try {
                              FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification();
                            } catch (e) {
                              debugPrint('$e');
                            }
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
