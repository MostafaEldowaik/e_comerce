
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app/view/screen/auth/email_verification_signin_signup.dart';
import 'package:e_comerce_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:e_comerce_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:e_comerce_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:e_comerce_app/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:e_comerce_app/view/screen/auth/login.dart';
import 'package:e_comerce_app/view/screen/auth/signup.dart';
import 'package:e_comerce_app/view/screen/auth/success_signup.dart';
import 'package:e_comerce_app/view/screen/auth/verifycodesignup.dart';
import 'package:e_comerce_app/view/screen/home_sceen.dart';
import 'package:e_comerce_app/view/screen/language.dart';
import 'package:e_comerce_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'core/middleware/mymiddleware.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const Language() , middlewares: [
    MyMiddleWare()
  ]),
  //GetPage(name: "/", page: () => Test()),
  ///////////////
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  // GetPage(name: AppRoute.verfiyCode, page: ({ required String email}) =>  VerfiyCode(email: email) ),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.successResetpassword, page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoute.emailVerificationScreen, page: () => const EmailVerificationScreen()),

];
 