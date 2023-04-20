import 'package:e_comerce/core/constant/routes.dart';
import 'package:e_comerce/data/datasource/fire_base_remote/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          isAction
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    setState(() {
                      isAction = true;
                    });
                    FireBaseAuthDataSource.changePasswordUsingReAuthenticate(
                            oldPassword: '123456789', newPassword: '123789456')
                        .then((value) {
                      setState(() {
                        isAction = false; 
                      });
                    });
                  },
                  child: const Text('Change Password'),
                ),

          //////============///
          const SizedBox(height: 20),

          TextButton(
            onPressed: () {
              FireBaseAuthDataSource.signOut();
              Get.offNamed(AppRoute.login);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
