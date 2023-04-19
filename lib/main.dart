
import 'package:e_comerce/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
//ffffff
//ghjhgff
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  Map firebaseConfig = {
  "apiKey": "AIzaSyDQx5uxxD57XF5V_0RL8vJB9RugymxbX4Y",
  "authDomain": "ecomerceapp-ad5a4.firebaseapp.com",
  "projectId": "ecomerceapp-ad5a4",
  "storageBucket": "ecomerceapp-ad5a4.appspot.com",
  "messagingSenderId": "322090319557",
  "appId": "1:322090319557:web:b8c2893e51afa22b847aac"
  };


  await Firebase.initializeApp(
    options:    GetPlatform.isWeb
  ? FirebaseOptions(
      apiKey: firebaseConfig['apiKey'],
      appId: firebaseConfig['appId'],
      messagingSenderId: firebaseConfig['messagingSenderId'],
      projectId: firebaseConfig['projectId'],
      storageBucket: firebaseConfig['storageBucket']
,    ):null,
  );

  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: controller.appTheme, 
      // routes: routes,
      getPages: routes,
    );
  }
}
