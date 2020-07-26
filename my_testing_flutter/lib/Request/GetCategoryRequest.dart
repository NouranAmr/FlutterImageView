import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mytestingflutter/response/CarSalesBrandModel.dart';
import 'package:mytestingflutter/response/Categories.dart';
import 'package:mytestingflutter/utils/Constants.dart';
import 'package:http/http.dart';

Future<Categories> getCategory(int categoryID, int languageId) async {
  var queryParameters = {
    'id': '$categoryID',
  };
  var uri = Uri.http(
      BASE_URL, '/api/categories/languageId=$languageId', queryParameters);
  final response = await get(uri);
  if (response.statusCode == 200) {
    debugPrint("getCategory success");
    return Categories.fromJson(json.decode(response.body));
  } else {
    debugPrint("getCategory failed");
    throw Exception('Failed to load Category');
  }
}
