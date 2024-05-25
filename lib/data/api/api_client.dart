import 'package:get/get.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({ required this.appBaseUrl, required this.sharedPreferences }){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Methods': '*',
      'Access-Control-Allow-Origin': '*'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try{
      Response response = await get(
        uri,
        headers: headers??_mainHeaders
      );
      return response;
    } catch(e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  Future<Response> postData(String uri, dynamic body) async {
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      print("posting " + response.toString());
      return response;
    } catch(e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}