// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:el_rashedy_restaurant/core/aap_image_assets.dart';
// import 'package:el_rashedy_restaurant/core/app_colors.dart';
// import 'package:el_rashedy_restaurant/model/sub_category_model.dart';
// import 'package:el_rashedy_restaurant/widgets/custom_text_widet.dart';
// import 'package:el_rashedy_restaurant/widgets/default_snak_bar.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddSubCategoryAdmin extends StatefulWidget {
//   const AddSubCategoryAdmin({super.key, required this.mainCategoryId});
//   final String mainCategoryId;
//   @override
//   State<AddSubCategoryAdmin> createState() => _AddSubCategoryAdminState();
// }

// class _AddSubCategoryAdminState extends State<AddSubCategoryAdmin> {
//   ///========== variables ==================//
//   TextEditingController subCategoryController = TextEditingController();
//   TextEditingController subCategoryImageNameController =
//       TextEditingController();
//   File? imageFile;
//   final ImagePicker _picker = ImagePicker();
//   bool isActionFinish = true;

//   /// ==========  getImagePicker
//   getImagePicker({required ImageSource source}) async {
//     final XFile? image =
//         await _picker.pickImage(source: source, imageQuality: 10);
//     if (image != null) {
//       setState(() {
//         imageFile = File(image.path);
//       });
//     }
//   }

//   /// =======upload image to firebase
//   Future<void> uploadImage(String imageCategoryName) async {
//     final firebaseStorage = FirebaseStorage.instance;
//     if (imageFile != null) {
//       await firebaseStorage
//           .ref()
//           .child(
//             '${AppFirebaseStorageAssets.subCategoryImages}/$imageCategoryName',
//           )
//           .putFile(imageFile!);
//     }
//   }

//   /// ====== add sub category
//   Future<void> addSubCategory(
//       SubCategoryModel subCategoryModel, String mainCategoryId) async {
//     CollectionReference subCategoryRef = FirebaseFirestore.instance
//         .collection('mainCategory')
//         .doc(mainCategoryId)
//         .collection('subCategories');
//     Map data = subCategoryModel.toJsonData();
//     await subCategoryRef.add(data);
//   }

//   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       /// ========== App Bar ============= //
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//         title: const CustomText(
//           fontSize: 18.0,
//           textColor: Colors.black,
//           textString: "اضافه قسم فرعي",
//           fontWeight: FontWeight.bold,
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.grey.shade100,
//         elevation: 0.0,
//       ),

//       /// ================ Body =================//
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 /// =============  SizedBox ===//
//                 const SizedBox(height: 10.0),

//                 /// =============  ================//
//                 imageFile != null
//                     ? Padding(
//                         padding: const EdgeInsets.all(14.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: FileImage(imageFile!),
//                                   fit: BoxFit.cover),
//                               borderRadius: BorderRadius.circular(
//                                 13.0,
//                               ),
//                               border:
//                                   Border.all(color: Colors.redAccent.shade700)),
//                           height: 250,
//                           width: double.infinity,
//                         ),
//                       )
//                     : GestureDetector(
//                         onTap: () {
//                           //    await getImagePicker();
//                           /////////////////////////////////////////////////////////////////
//                           showModalBottomSheet(
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(25.0),
//                                 topRight: Radius.circular(25.0),
//                               ),
//                             ),
//                             context: context,
//                             builder: (BuildContext context) {
//                               return Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 12.0),
//                                     TextButton.icon(
//                                       onPressed: () async {
//                                         await getImagePicker(
//                                             source: ImageSource.gallery);
//                                         // === TODO
//                                       },
//                                       icon: Icon(
//                                         Icons.image,
//                                         color: Colors.grey.shade700,
//                                       ),
//                                       label: const CustomText(
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.bold,
//                                         textColor: Colors.black87,
//                                         textString: "إضافة صورة من المعرض",
//                                       ),
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () async {
//                                         await getImagePicker(
//                                             source: ImageSource.camera);
//                                         // === TODO
//                                       },
//                                       label: const CustomText(
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.bold,
//                                         textColor: Colors.black87,
//                                         textString: "التقاط صورة من الكاميرا",
//                                       ),
//                                       icon: Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.grey.shade700,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8.0),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                           /////////////////////////////////////////////////////////////
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(14.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                   13.0,
//                                 ),
//                                 border: Border.all(
//                                     color: Colors.redAccent.shade700)),
//                             height: 250,
//                             child: const Center(
//                               child: CustomText(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   textColor: Colors.black,
//                                   textString: 'اضف صوره للقسم *'),
//                             ),
//                           ),
//                         ),
//                       ),

//                 /// ======== === mainCategory  Name ======== ======= //
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: TextFormField(
//                     controller: subCategoryController,
//                     cursorColor: AppColors.iconColor,
//                     decoration: InputDecoration(
//                       hintText: "اضف اسم القسم الفرعى *",
//                       hintStyle: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                       //================= enabledBorder ==========//
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9.0),
//                         borderSide:
//                             BorderSide(color: AppColors.iconColor, width: 1.0),
//                       ),
//                       //================= focusedBorder =========//
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9.0),
//                         borderSide:
//                             BorderSide(color: AppColors.iconColor, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// ======== === mainCategory  Name ======== ======= //
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: TextFormField(
//                     controller: subCategoryImageNameController,
//                     cursorColor: AppColors.iconColor,
//                     decoration: InputDecoration(
//                       hintText: "اضف اسم الصوره باللغه الانجليزية *",
//                       hintStyle: const TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.bold),
//                       //================= enabledBorder ==========//
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9.0),
//                         borderSide:
//                             BorderSide(color: AppColors.iconColor, width: 1.0),
//                       ),
//                       //================= focusedBorder =========//
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9.0),
//                         borderSide:
//                             BorderSide(color: AppColors.iconColor, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// ======== === Button Action ======== ======= //
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     isActionFinish
//                         ? OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                                 side: BorderSide(
//                                     color: Colors.greenAccent.shade700)),
//                             onPressed: () async {
//                               if (imageFile == null ||
//                                   subCategoryController.text.trim().isEmpty ||
//                                   subCategoryImageNameController.text
//                                       .trim()
//                                       .isEmpty) {
//                                 return showDefaultSnackBar(
//                                     context, "أملأ فراغات ",
//                                     color: Colors.redAccent.shade700 ,
//                                 );
//                               } else {
//                                 setState(() {
//                                   isActionFinish = false ;
//                                 });
//                                 uploadImage(subCategoryImageNameController.text
//                                         .trim())
//                                     .then((value) {
//                                   addSubCategory(
//                                     SubCategoryModel(
//                                       id: '',
//                                       categoryName:
//                                           subCategoryController.text.trim(),
//                                       picturePath:
//                                           subCategoryImageNameController.text
//                                               .trim(),
//                                     ),
//                                     widget.mainCategoryId,
//                                   ).then((value) {
//                                     setState(() {
//                                       isActionFinish = true ;
//                                     });
//                                     return showDefaultSnackBar(
//                                       context,
//                                       "🥳 تم الأضافة بنجاح ",
//                                     color: Colors.greenAccent.shade700 ,
//                                     );
//                                   });
//                                 });
//                               }
//                             },
//                             child: CustomText(
//                               fontSize: 19.0,
//                               fontWeight: FontWeight.bold,
//                               textColor: Colors.greenAccent.shade700,
//                               textString: "اضف",
//                             ),
//                           )
//                         : Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.blueAccent.shade700,
//                             ),
//                           ),
//                     // ===================== cancel ============//
//                     OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                           side: BorderSide(color: Colors.redAccent.shade700)),
//                       onPressed: () {
//                         setState(() {
//                           imageFile = null;
//                          subCategoryController.text = "";
//                           subCategoryImageNameController.text = "";
//                         });
//                       },
//                       child: CustomText(
//                         fontSize: 19.0,
//                         fontWeight: FontWeight.bold,
//                         textColor: Colors.redAccent.shade700,
//                         textString: "الغاء",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }