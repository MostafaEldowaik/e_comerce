
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
  "apiKey": "AIzaSyAYxn_Pbv3gXiPJZL-PbsP7MlZyMR4YAZU",
  "authDomain": "ecomerce-7d40a.firebaseapp.com",
  "projectId": "ecomerce-7d40a",
  "storageBucket": "ecomerce-7d40a.appspot.com",
  "messagingSenderId": "1069942214247",
  "appId": "1:1069942214247:web:f016d2f4ba6067843d8ec2"
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
