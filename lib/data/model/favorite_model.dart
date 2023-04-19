/// this [method] is used to store favorite data locally . 
class FavoriteModel {
  late final String categoryId;
  late final List<String> itemListIds;

  FavoriteModel({
    required this.categoryId,
    required this.itemListIds,
  });

  factory FavoriteModel.fromJsonData({
    required Map jsonUserData,
  }) {
    return FavoriteModel(
      categoryId: jsonUserData['categoryId'],
      itemListIds: jsonUserData['itemListIds'],
    );
  }

  Map<String, dynamic> toJsonData() {
    final Map<String, dynamic> favoriteMap = <String, dynamic>{};
    favoriteMap['categoryId'] = categoryId;
    favoriteMap['itemListIds'] = itemListIds;
    return favoriteMap;
  }
}
