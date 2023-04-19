import 'package:dartz/dartz.dart';
import 'package:e_comerce_app/core/error/failure.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class FireStoreDataBase {
//
//   static Future<String> getData(String imagePath) async {
//     try {
//       var imagePathUrlFromFireStore = await getDownloadURLFilePath(imagePath);
//       print(imagePathUrlFromFireStore) ;
//       return imagePathUrlFromFireStore;
//     } catch (e) {
//       return "1.jpg" ;
//     }
//   }
//   static Future<Either<Failure, String>> getDataEither(String imagePath) async {
//     try {
//       var imagePathUrlFromFireStore = await getDownloadURLFilePath(imagePath);
//       return right(imagePathUrlFromFireStore);
//     } catch (e) {
//       return left(
//         FirebaseFailure(message: e.toString()),
//       );
//     }
//   }
//   static Future<String> getDownloadURLFilePath(String imagePath) async {
//     String downloadURL =
//         await FirebaseStorage.instance.ref().child(imagePath).getDownloadURL();
//     return downloadURL;
//   }
// }


class FireStoreDataBase {
  String? downloadURL;

  Future getData(String imagePath) async {
    try {
      await downloadURLExample(imagePath);
       // print(downloadURL) ;
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLExample(String imagePath) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child(imagePath)
        .getDownloadURL();
     // debugPrint(downloadURL.toString());

  }
}