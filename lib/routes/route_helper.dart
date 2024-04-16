import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/pages/medical_item/popular_medical_item_detail.dart';
import 'package:khoaluan_flutter/pages/splash/splash_page.dart';

import '../pages/cart/cart_page.dart';
import '../pages/home/home_page.dart';
import '../pages/medical_item/recommended_medical_item_detail.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularMedicalItem = "/popular-medical-item";
  static const String recommendedMedicalItem = "/recommended-medical-item";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularMedicalItem(int pageId, String page) => '$popularMedicalItem?pageId=$pageId&page=$page';
  static String getRecommendedMedicalItem(int pageId, String page) => '$recommendedMedicalItem?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),

    GetPage(name: popularMedicalItem, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularMedicalItemDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedMedicalItem, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedMedicalItemDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn)
  ];
}