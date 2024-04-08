import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/pages/medical_item/popular_medical_item_detail.dart';

import '../pages/medical_item/recommended_medical_item_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularMedicalItem = "/popular-medical-item";
  static const String recommendedMedicalItem = "/recommended-medical-item";

  static String getInitial() => '$initial';
  static String getPopularMedicalItem(int pageId) => '$popularMedicalItem?pageId=$pageId';
  static String getRecommendedMedicalItem(int pageId) => '$recommendedMedicalItem?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainMedicalItemPage()),

    GetPage(name: popularMedicalItem, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularMedicalItemDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedMedicalItem, page: (){
      var pageId = Get.parameters['pageId'];
      return RecommendedMedicalItemDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn,)
  ];
}