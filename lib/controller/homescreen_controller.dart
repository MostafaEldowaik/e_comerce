import 'package:e_comerce_app/data/datasource/fire_base_remote/firebase_store_crud.dart';
import 'package:get/get.dart';
import '../core/constant/constanst.dart';
import '../core/services/services.dart';

class HomeScreenController extends GetxController {}

class HomeScreenControllerImp extends HomeScreenController {
  MyServices myServices = Get.find();

  // ===============================//
  String  categoryId =  AppSharedPreferencesStrings.inationalDataOfcategoryId;

  selectCategory({required String docId}) {
    categoryId = docId;
    saveCategoryID(docId);
    update();
  }

  saveCategoryID(String dataCategoryId) {
    myServices.sharedPreferences
        .setString(AppSharedPreferencesStrings.categoryId, dataCategoryId);
  }

  String? categeryIdFromSharedPref() {
    return myServices.sharedPreferences
        .getString(AppSharedPreferencesStrings.categoryId);
  }

  initialCategoryId() {
    String? catId = categeryIdFromSharedPref();
    if (catId == null) {
      FirebaseStoreCrudOperationDataSource.getIdOfFirstCategory().then((value) {
        categoryId = value;
        update();
      });
    }
    else{
      categoryId = catId;
        update();
    }
  }

  // =====================//
  // String? username;
  // String? id;

  // initialData() {
  //   username = myServices.sharedPreferences.getString("username");
  //   id = myServices.sharedPreferences.getString("id");
  // }

  @override
  void onInit() {
    //initialData();
    initialCategoryId();
    super.onInit();
  }
}
