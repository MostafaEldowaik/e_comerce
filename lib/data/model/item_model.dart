import 'package:cloud_firestore/cloud_firestore.dart';

/// this discription [!TODO]
/// [favoriteUserList] , note that i add list in item model
/// instead of creating another model for favorite items
/// when a user add item to favorites the id of user is added directly in favorite list
/// when return all items in screen check that user id is exist or not if exist appear fav icon red color
/// [AlgorithmFunctions.isUserIDExistAndisNotEmpty] to check the item is exist or not

class ItemModel {
  late final String id;
  late final String nameEn;
  late final String nameAr;
  late final String descriptionEn;
  late final String descriptionAr;
  late final String imagePath;
  late final int counts;
  late final bool active;
  late final double discount;
  late final double price;
  late final Timestamp createdAt;
  late final List<String>
      favoriteUserList; // instead of creating favorite model

  ItemModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.imagePath,
    required this.counts,
    required this.active,
    required this.discount,
    required this.price,
    required this.createdAt,
    required this.favoriteUserList,
  });

  ItemModel.fromJsonData({
    required String itemId,
    required Map jsonUserData,
  }) {
    id = itemId;
    nameEn = jsonUserData['nameEn'];
    nameAr = jsonUserData['nameAr'];
    descriptionEn = jsonUserData['descriptionEn'];
    descriptionAr = jsonUserData['descriptionAr'];
    imagePath = jsonUserData['imagePath'];
    counts = jsonUserData['counts'];
    active = jsonUserData['active'];
    discount = jsonUserData['discount'];
    price = jsonUserData['price'];
    createdAt = jsonUserData['createdAt'];
    favoriteUserList = (jsonUserData['favoriteUserList'] as List)
        .map((userId) => userId.toString() )
        .toList();
  }

  Map<String, dynamic> toJsonData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['descriptionEn'] = descriptionEn;
    data['descriptionAr'] = descriptionAr;
    data['imagePath'] = imagePath;
    data['counts'] = counts;
    data['active'] = active;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['favoriteUserList'] = favoriteUserList;
    return data;
  }
}
