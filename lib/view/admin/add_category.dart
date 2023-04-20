import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce/core/constant/constanst.dart';
import 'package:e_comerce/data/model/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/default_snackbar.dart';

class AddMainCategoryAdmin extends StatefulWidget {
  const AddMainCategoryAdmin({Key? key}) : super(key: key);

  @override
  State<AddMainCategoryAdmin> createState() => _AddMainCategoryAdminState();
}

class _AddMainCategoryAdminState extends State<AddMainCategoryAdmin> {
  ///========== variables ==================//
  TextEditingController categoryNameEnController = TextEditingController();
  TextEditingController categoryNameAnController = TextEditingController();
  TextEditingController mainCategoryImageNameController =
      TextEditingController();
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool isActionFinish = true;

  /// ==========  getImagePicker
  getImagePicker({required ImageSource source}) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 10,
    );
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  /// ======= upload image to firebase
  Future<void> uploadImage(String imageCategoryName) async {
    final firebaseStorage = FirebaseStorage.instance;
    if (imageFile != null) {
      await firebaseStorage
          .ref()
          .child('${AppFirebaseStorageAssets.categoryImagePath}/$imageCategoryName')
          .putFile(imageFile!);
    }
  }

  /// ====== add main category
  Future<void> addCategory(CategoryModel categoryModel) async {
    CollectionReference categoryRef =
        FirebaseFirestore.instance.collection(AppFireStoreCollectionName.categoryCollection);
    Map data = categoryModel.toJsonData();
    await categoryRef.add(data);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ========== App Bar ============= //
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text("أضافه قسم")  ,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0.0,
      ),

      /// ================ Body =================//
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// =============  SizedBox ===//
                const SizedBox(height: 10.0),

                /// =============  ================//
                imageFile != null
                    ? Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                13.0,
                              ),
                              border:
                                  Border.all(color: Colors.redAccent.shade700)),
                          height: 250,
                          width: double.infinity,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          //    await getImagePicker();
                          /////////////////////////////////////////////////////////////////
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12.0),
                                    TextButton.icon(
                                      onPressed: () async {
                                        await getImagePicker(
                                            source: ImageSource.gallery);
                                        // === TODO
                                      },
                                      icon: Icon(
                                        Icons.image,
                                        color: Colors.grey.shade700,
                                      ),
                                      label:const Text("إضافة صورة من المعرض",)  
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        await getImagePicker(
                                            source: ImageSource.camera);
                                        // === TODO
                                      },
                                      label: const Text("التقاط صورة من الكاميرا",) ,
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              );
                            },
                          );
                          /////////////////////////////////////////////////////////////
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  13.0,
                                ),
                                border: Border.all(
                                    color: Colors.redAccent.shade700)),
                            height: 250,
                            child: const Center(
                              child:Text('اضف صوره للقسم *',) , 
                                  ////
                            ),
                          ),
                        ),
                      ),

                /// ======== === Category  Name  EnGLISH ======== ======= //
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: categoryNameAnController,
                    cursorColor: Colors.grey ,
                    decoration: InputDecoration(
                      hintText: "اضف اسم القسم الرئيسى *",
                      hintStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      //================= enabledBorder ==========//
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                      ),
                      //================= focusedBorder =========//
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide:
                          const  BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                  ),
                ),

                /// ======== === mainCategory  Name ======== ======= //
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: mainCategoryImageNameController,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      hintText: "اضف اسم الصوره باللغه الانجليزية *",
                      hintStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                      //================= enabledBorder ==========//
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide:
                           const BorderSide(color: Colors.red, width: 1.0),
                      ),
                      //================= focusedBorder =========//
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide:
                           const  BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                  ),
                ),

                /// ======== === Button Action ======== ======= //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isActionFinish
                        ? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: Colors.greenAccent.shade700)),
                            onPressed: () async {
                              if (imageFile == null ||
                                  categoryNameEnController.text.trim().isEmpty ||
                                  mainCategoryImageNameController.text
                                      .trim()
                                      .isEmpty) {
                                return showDefaultSnackBar  (
                                    context, "أملأ فراغات ",
                                    color: Colors.redAccent.shade700);
                              } else {
                                setState(() {
                                  isActionFinish = false;
                                });
                                uploadImage(mainCategoryImageNameController.text
                                        .trim())
                                    .then((value) {
                                  addCategory(
                                    CategoryModel(
                                      id: '', 
                                      nameEn: categoryNameEnController.text.trim(),
                                      nameAr: categoryNameEnController.text.trim(),
                                      imagePath: mainCategoryImageNameController.text.trim(), 
                                      createdAt: Timestamp.fromDate(DateTime.now()),
                                      ),
                                  ).then((value) {
                                    setState(() {
                                      isActionFinish = true;
                                    });
                                    return showDefaultSnackBar(
                                      color: Colors.greenAccent.shade700,
                                      context,
                                      "🥳 تم الأضافة بنجاح ",
                                    );
                                  });
                                });
                              }
                            },
                            child: const Text('أضف')
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent.shade700,
                            ),
                          ),
                    // ===================== cancel ============//
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.redAccent.shade700)),
                      onPressed: () {
                        setState(() {
                          imageFile = null;
                          categoryNameEnController.text = "";
                          mainCategoryImageNameController.text = "";
                        });
                      },
                      child:const Text( "الغاء",) 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
