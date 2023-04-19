

import '../../../core/class/curd.dart';
import '../../../core/constant/routes.dart';

class HomeData {
  Curd crud;
  HomeData(this.crud);
  getData() async {
    var response = await crud.postData(AppRoute.homeScreen, {});
    return response.fold((l) => l, (r) => r);
  }
}