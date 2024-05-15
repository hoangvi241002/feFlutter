import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/auth_controller.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/controller/location_controller.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:khoaluan_flutter/data/repository/auth_repo.dart';
import 'package:khoaluan_flutter/data/repository/cart_repo.dart';
import 'package:khoaluan_flutter/data/repository/location_repo.dart';
import 'package:khoaluan_flutter/data/repository/popular_product_repo.dart';
import 'package:khoaluan_flutter/data/repository/search_product_repo.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/order_controller.dart';
import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../controller/user_controller.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/user_repo.dart';

Future <void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => SearchProductRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  // controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => SearchProductController(searchProductRepo: Get.find()));

  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}