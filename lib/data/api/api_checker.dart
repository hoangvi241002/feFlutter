import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/show_custom_snackbar.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response){
    if(response.statusCode == 401){
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}