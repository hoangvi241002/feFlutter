import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:khoaluan_flutter/data/repository/cart_repo.dart';
import 'package:khoaluan_flutter/data/repository/popular_product_repo.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future <void> init()async {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}