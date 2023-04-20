import 'package:e_comerce/core/constant/color.dart';
import 'package:e_comerce/core/constant/constanst.dart';
import 'package:e_comerce/data/datasource/fire_base_remote/firebase_store_crud.dart';
import 'package:e_comerce/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/homescreen_controller.dart';
import '../../data/datasource/fire_base_remote/firebase_storage_files.dart';
import '../../data/model/item_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenControllerImp homeController=Get.put(HomeScreenControllerImp());

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: [
          Container(
            height: 55,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Find Product",
                    hintStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 60,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const ListTile(
                    title: Text(
                      "A Summer Surprise",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    subtitle: Text(
                      "cashback 20%",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                Positioned(
                  top: -17,
                  right: -17,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: AppColor.secondColor,
                        borderRadius: BorderRadius.circular(150)),
                  ),
                ),
              ],
            ),
          ),
          // =========== category =======================//
          Container(
            child: StreamBuilder(
              stream: FirebaseStoreCrudOperationDataSource
                  .getAllCategoriesAsStream(),
              builder: (context, snapshot) {
                ///
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                      height: 90,
                      child: ListView.separated(
                        separatorBuilder: (context,snapshot)=>const SizedBox(width: 10,),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // =====================================//
                          var docId = snapshot.data!.docs[index].id;
                          var docData =
                              snapshot.data!.docs[index].data() as Map;
                          CategoryModel categoryModel =
                              CategoryModel.fromJsonData(
                                  categoryId: docId, jsonCategoryData: docData);
                          // ----------------------------------//

                          return GestureDetector(
                            onTap: (){ homeController.selectCategory(docId: docId) ;
                             FirebaseStoreCrudOperationDataSource
                                                        .getIdOfFirstCategory();
                            },
                            child:  SizedBox(
                              //height: 60,
                              child: FutureBuilder(
                                future: FireStoreDataBase().getData(
                                    "/${AppFirebaseStorageAssets.categoryImagePath}/${categoryModel.imagePath}"),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text(
                                      "Something went wrong",
                                    );
                                  }
                                  // connectionState == ConnectionState.done
                                  else if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(19),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Image.network(
                                              snapshot.data.toString()),
                                        ),
                                        Text(
                                          categoryModel.id,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColor.black),
                                        ),
                                      ],
                                    );
                                  } else {
                                    print(snapshot.hasData);
                                    return Text("the image loading ---");
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ));
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("check internet and Try again ! "),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Colors.redAccent.shade700),
                  );
                }
              },
            ),
          ),
          const Text("Product For You",style: TextStyle(fontSize: 20,color:AppColor.secondColor,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          GetBuilder<HomeScreenControllerImp>(
            init: HomeScreenControllerImp(),
            builder: (controller) {
            return controller.categoryId =="initial" ? Container():SizedBox(
              height: 200,
              child: StreamBuilder(
                stream: FirebaseStoreCrudOperationDataSource.getAllItemsOfACertainCategoryAsStream(categoryId: controller.categoryId),
                builder: (context, snapshot) {
                  ///
                  if (snapshot.hasData && snapshot.data != null) {
                    return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // =====================================//
                            var docId = snapshot.data!.docs[index].id;
                            var docData =
                            snapshot.data!.docs[index].data() as Map;
                            ItemModel itemModel =
                            ItemModel.fromJsonData(itemId: docId, jsonUserData: docData);
                            // ----------------------------------//

                            return SizedBox(
                              //height: 60,
                              child: FutureBuilder(
                                future: FireStoreDataBase().getData(
                                    "/${AppFirebaseStorageAssets.itemImagePath}/${itemModel.imagePath}"),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text(
                                      "Something went wrong",
                                    );
                                  }
                                  // connectionState == ConnectionState.done
                                  else if (snapshot.hasData) {
                                    return Stack(children: [
                                      Container(
                                        //padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            Text(itemModel.nameAr),
                                            Image.network(snapshot.data.toString(),height: 100,width: 150,fit:BoxFit.fill,),
                                          ],
                                        ),
                                      )
                                    ],);
                                  } else {
                                    print(snapshot.hasData);
                                    return const Text("the image loading ---");
                                  }
                                },
                              ),
                            );
                          },
                        ));
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("check internet and Try again ! "),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Colors.redAccent.shade700),
                    );
                  }
                },
              ),
            ) ;
          },),

        ],
      ),
    ));
  }
}
