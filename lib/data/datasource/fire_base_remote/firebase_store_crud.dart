import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce/core/constant/constanst.dart';
import 'package:e_comerce/data/model/item_model.dart';

class FirebaseStoreCrudOperationDataSource {
  // === === Categories ====//
  static Stream<QuerySnapshot?> getAllCategoriesAsStream() {
    /// Get All Categories As [Stream]
    CollectionReference categories = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection);
    return categories.snapshots();
  }

  static Future<QuerySnapshot?> getAllCategoriesAsFuture() async {
    /// Get All Categories As [Future]
    CollectionReference categories = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection);
    return categories.get();
  }

  static Future<String> getIdOfFirstCategory() async {
    /// Get the id of first category [Future]
    String firstId = "";
    CollectionReference categories = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection);

    QuerySnapshot querySnapshot = await categories.get();
    firstId = querySnapshot.docs.first.id;
    return firstId ; 
  }

  // === === items ====//
  static Stream<QuerySnapshot?> getAllItemsOfACertainCategoryAsStream(
      {required String categoryId}) {
    /// Get All iteams of a certain category [Stream]
    CollectionReference items = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection)
        .doc(categoryId)
        .collection(AppFireStoreCollectionName.itemCollection);
    return items.snapshots();
  }

  static Future<QuerySnapshot?> getAllItemsOfACertainCategoryAsFuture(
      {required String categoryId}) async {
    CollectionReference items = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection)
        .doc(categoryId)
        .collection(AppFireStoreCollectionName.itemCollection);
    return items.get();
  }

  ///  ========= [add user id to favorite List ] ============== ///
  static Future<void> addUserToFavoriteListOfItemModel({
    required String userId,
    required String categoryId,
    required String itemId,
  }) async {
    List<String> favoriteUserList = [];

    CollectionReference itemsRef = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection)
        .doc(categoryId)
        .collection(AppFireStoreCollectionName.itemCollection);

    DocumentReference updatedItem = itemsRef.doc(itemId);
    updatedItem.get().then((value) {
      ItemModel itemModel = ItemModel.fromJsonData(
          itemId: value.id, jsonUserData: value.data() as Map);
      favoriteUserList = itemModel.favoriteUserList;
    });

    // add the the user id to favorite list in item model
    favoriteUserList.add(userId);

    // update is used to update field not all itemModel
    return await itemsRef
        .doc(itemId)
        .update({"favoriteUserList": favoriteUserList});
  }

  ///  ========= [Delete user id form favorite List ] ============== ///
  static Future<void> deleteUserFromFavoriteListOfItemModel({
    required String userId,
    required String categoryId,
    required String itemId,
  }) async {
    List<String> favoriteUserList = [];

    CollectionReference itemsRef = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection)
        .doc(categoryId)
        .collection(AppFireStoreCollectionName.itemCollection);

    DocumentReference updatedItem = itemsRef.doc(itemId);

    updatedItem.get().then((value) {
      ItemModel itemModel = ItemModel.fromJsonData(
          itemId: value.id, jsonUserData: value.data() as Map);
      favoriteUserList = itemModel.favoriteUserList;
    });

    // add the the user id to favorite list in item model
    favoriteUserList.remove(userId);

    // update is used to update field not all itemModel
    return await itemsRef
        .doc(itemId)
        .update({"favoriteUserList": favoriteUserList});
  }

  static List<String> returnCurrentFavoriteUserList({
    required String categoryId,
    required String itemId,
  }) {
    List<String> favoriteUserList = [];

    CollectionReference itemsRef = FirebaseFirestore.instance
        .collection(AppFireStoreCollectionName.categoryCollection)
        .doc(categoryId)
        .collection(AppFireStoreCollectionName.itemCollection);

    DocumentReference updatedItem = itemsRef.doc(itemId);

    updatedItem.get().then((value) {
      ItemModel itemModel = ItemModel.fromJsonData(
          itemId: value.id, jsonUserData: value.data() as Map);
      favoriteUserList = itemModel.favoriteUserList;
    });

    return favoriteUserList;
  }
}
