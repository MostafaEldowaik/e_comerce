
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  late final String id;
  late final String nameEn;
  late final String nameAr;
  late final String imagePath;
  late final Timestamp createdAt;

  CategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.createdAt,
  });

  CategoryModel.fromJsonData({
    required String categoryId,
    required Map jsonCategoryData,
  }) {
    id = categoryId;
    nameEn = jsonCategoryData['nameEn'];
    nameAr = jsonCategoryData['nameAr'];
    imagePath = jsonCategoryData['imagePath'];
    createdAt = jsonCategoryData['createdAt'];
  }

  Map<String, dynamic> toJsonData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['imagePath'] = imagePath;
    data['createdAt'] = createdAt;
    return data;
  }
}


