import 'package:e_comerce_app/core/class/stautusrequest.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/imgaeasset.dart';


class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
        child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250))
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
        child: Lottie.asset(AppImageAsset.offline,
            width: 250, height: 250))
        : statusRequest == StatusRequest.serverfailure
        ? Center(
        child: Lottie.asset(AppImageAsset.server,
            width: 250, height: 250))
        : statusRequest == StatusRequest.failure
        ? Center(
        child: Lottie.asset(AppImageAsset.noData,
            width: 250, height: 250, repeat: true))
        : widget;
  }
}
//=========================//
class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
        child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250))
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
        child: Lottie.asset(AppImageAsset.offline,
            width: 250, height: 250))
        : statusRequest == StatusRequest.serverfailure
        ? Center(
        child: Lottie.asset(AppImageAsset.server,
            width: 250, height: 250))
        : widget;
  }
}

class HandlingDataViewFuture  extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot ;
  final Widget child ;
  const HandlingDataViewFuture({
    Key? key,
    required this.snapshot,
    required this.child ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(snapshot.hasError){
      //=== server error ====//
      return Lottie.asset(AppImageAsset.server,
          width: 250, height: 250);
    }
    else if(snapshot.hasData && snapshot.data !=null ){
     return  child ;
    }
    return  Center(
        child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250) );
  }
}
