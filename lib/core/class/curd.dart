import 'dart:convert';
import 'package:e_comerce_app/core/functions/checkinternet.dart';
import 'package:dartz/dartz.dart';
import '../../../core/class/stautusrequest.dart';
import 'package:http/http.dart' as http;

class Curd {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (checkInternet()) {
        var response = await http.post(Uri.parse(linkurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = await jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return left(StatusRequest.serverfailure);
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return left(StatusRequest.serverfailure);
    }
  }
}
