import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app/core/constant/constanst.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class FireBaseAuthDataSource {
  // ===== login to firebase =======//
  static Future<String> login({
    FormState? formdata,
    UserCredential? userCredential,
    required String email,
    required String password,
  }) async {
    if (formdata!.validate()) {
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential != null) {
          if (userCredential.user!.emailVerified) {
            return UserAuthenticationStatus.isAuthenticatedAndEmailVerified;
          } else {
            return UserAuthenticationStatus.isAuthenticated;
          }
        }
        return UserAuthenticationStatus.isNotAuthenticated;
      } on FirebaseAuthException catch (e) {
        if (e.code == FireBaseError.userNotFound ||
            e.code == FireBaseError.worngPassword) {
          return FireBaseError.usernameOrPasswordIsNotTrue;
        }
        return FireBaseError.tryAgain;
      }
    } else {
      return FireBaseError.checkYourTextField;
    }
  }

  // ===== Sigin Up =====//

  static Future<String> signUp({
    FormState? formdata,
    UserCredential? userCredential,
    required String email,
    required String password,
    required String phone,
    required String userName,
  }) async {
    if (formdata!.validate()) {
      try {
        /////////////////////////////////////

        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String userId = userCredential.user!.uid;

        UserModel userModel = UserModel(
          id: userId,
          userName: userName.trim().toLowerCase(),
          password: password.trim(),
          phone: phone.trim(),
          email: email.trim().toLowerCase(),
        );

        var returnedValue = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .set(userModel.toJsonData())
            .then((value) {
          return UserAuthenticationStatus.isAuthenticated;
        });
        print(returnedValue);
        return returnedValue;
        /////////////////////////////////////////
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        // return FireBaseError.tryAgain;
        return e.toString();
      }
      // return UserAuthenticationStatus.isAuthenticated;
    } else {
      return FireBaseError.checkYourTextField;
    }
  }

//////
  // static addCreatedUserData(UserModel userModel) {
  //   CollectionReference userRef =
  //       FirebaseFirestore.instance.collection(FireBaseCollectionNames.users);
  //   Map userData = userModel.toJsonData();
  //   userRef.add(userData);
  // }

  // ============== LogOut =====================//
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

// ================ Rest the password =========== //
  static restPasswordUsingEmail({required String email}) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => print("Password reset email sent"))
        .catchError(
            (error) => print("Error sending password reset email: $error"));
  }

// ================ Change the password =========== //
  static changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.updatePassword(newPassword);
      debugPrint("Password has been changed successfully.");
    } catch (error) {
      debugPrint("Password could not be changed: $error");
    }
  }
  // =============== change password using reauthenticat ======//

  static Future<void> changePasswordUsingReAuthenticate(
      {required String oldPassword, required String newPassword}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      var credential = EmailAuthProvider.credential(
        email: currentUser!.email.toString(),
        password: oldPassword,
      );
      await currentUser.reauthenticateWithCredential(credential);

      // Update password on firebase Authentication service
      await currentUser.updatePassword(newPassword);

      // Update password in firestore

    await  FirebaseFirestore.instance
          .collection(AppFireStoreCollectionName.users)
          .doc(currentUser.uid)
          .update({"password": newPassword});
 
      debugPrint('Password updated successfully!');
    } on FirebaseAuthException catch (e) {
      debugPrint('Error updating password: ${e.message}');
    }
  }
}

class FireBaseError {
  // === returned data from firebase  ====//
  static const String userNotFound = "user-not-found";
  static const String worngPassword = 'wrong-password';

  // === from developing   ====//
  static const String usernameOrPasswordIsNotTrue =
      "username or password is not true";
  static const String tryAgain = "try again";
  static const String checkYourTextField = "check your text field ";
}

class UserAuthenticationStatus {
  static const String isAuthenticatedAndEmailVerified =
      "isAuthenticated and vervified";
  static const String isAuthenticated = "isAuthenticated";
  static const String isNotAuthenticated = "isNotAuthebticated";
}

class FireBaseCollectionNames {
  static const String users = "Users";
}
