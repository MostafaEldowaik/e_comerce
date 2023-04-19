import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/routes.dart';
import '../services/services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("onboarding") == "1") {
     //   return const RouteSettings(name: AppRoute.login);
   UserAuthenticationStatus loginStatus =  FirebaseAuthenticationStatus.getTheStatus() ;
     if(loginStatus == UserAuthenticationStatus.isAuthenticatedAndEmailVerified){
      return const RouteSettings(name: AppRoute.homeScreen);
     }
     else if(loginStatus == UserAuthenticationStatus.isAuthenticated){
       return const RouteSettings(name: AppRoute.emailVerificationScreen);
     }
      else {
        return const RouteSettings(name: AppRoute.login);
      }
    
    //============================= //
     }
    return null;
    }
  }

//================= mahney Elbana to cheCK the status now ===================//

class FirebaseAuthenticationStatus {
  static UserAuthenticationStatus getTheStatus() {
   
    UserAuthenticationStatus loginStatus =
        UserAuthenticationStatus.isNotAuthenticated;

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      loginStatus = UserAuthenticationStatus.isNotAuthenticated;
  
    } else if (!user.emailVerified) {
      loginStatus = UserAuthenticationStatus.isAuthenticated;
    } else {
      loginStatus = UserAuthenticationStatus.isAuthenticatedAndEmailVerified;
    }
    debugPrint(user?.email);
    debugPrint(user?.emailVerified.toString());
    debugPrint(loginStatus.toString());

    return loginStatus; 
  }
}

enum UserAuthenticationStatus {
  isAuthenticatedAndEmailVerified,
  isAuthenticated,
  isNotAuthenticated
}
