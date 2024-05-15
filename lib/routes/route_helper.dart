import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/models/order_model.dart';
import 'package:khoaluan_flutter/pages/address/add_address_page.dart';
import 'package:khoaluan_flutter/pages/address/pick_address_map.dart';
import 'package:khoaluan_flutter/pages/auth/sign_in_page.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/pages/home/widgets/search_page.dart';
import 'package:khoaluan_flutter/pages/medical_item/popular_medical_item_detail.dart';
import 'package:khoaluan_flutter/pages/payment/payment_page.dart';
import 'package:khoaluan_flutter/pages/splash/splash_page.dart';

import '../pages/cart/cart_page.dart';
import '../pages/home/home_page.dart';
import '../pages/medical_item/recommended_medical_item_detail.dart';
import '../pages/payment/order_success_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularMedicalItem = "/popular-medical-item";
  static const String recommendedMedicalItem = "/recommended-medical-item";
  static const String cartPage = "/cart-page";
  static const String searchPage = "/search-page";
  static const String signIn = "/sign-in";

  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularMedicalItem(int pageId, String page) => '$popularMedicalItem?pageId=$pageId&page=$page';
  static String getRecommendedMedicalItem(int pageId, String page) => '$recommendedMedicalItem?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSearchPage() => '$searchPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id, int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status) => '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: () {
      PickAddressMap _pickAddress = Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: splashPage, page: () =>SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(name: signIn, page: () => SignInPage(), transition: Transition.fade),

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
      transition: Transition.fadeIn
    ),

    GetPage(name: searchPage, page: () => const SearchPage(), transition: Transition.fadeIn),

    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    }),
    GetPage(name: payment, page: () => PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),

        )
    )),
    GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      orderID:Get.parameters['id']!,
      status:Get.parameters["status"].toString().contains("success")?1:0,

    ))
  ];
}