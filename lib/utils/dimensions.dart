import 'package:get/get.dart';
class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.625;
  static double pageViewContainer = screenHeight/3.82;
  static double pageViewTextContainer = screenHeight/7.0;
  static double bottomPagePopular = screenHeight/7.33;

  // Dynamic height padding and margin
  static double height7 = screenHeight/125.71;
  static double height10 = screenHeight/84.0;
  static double height15 = screenHeight/56.0;
  static double height20 = screenHeight/42.0;
  static double height30 = screenHeight/28.0;
  static double height45 = screenHeight/18.67;

  // Dynamic width padding and margin
  static double width10 = screenHeight/84.0;
  static double width15 = screenHeight/56.0;
  static double width20 = screenHeight/42.0;
  static double width30 = screenHeight/28.0;
  static double width35 = screenHeight/25.14;
  static double width45 = screenHeight/18.67;
  static double width80 = screenHeight/11;

  // Radius
  static double radius15 = screenHeight/56.0;
  static double radius20 = screenHeight/42.0;
  static double radius30 = screenHeight/28.0;

  // font text
  static double font12 = screenHeight/73.33;
  static double font16 = screenHeight/55;
  static double font20 = screenHeight/44;
  static double font23 = screenHeight/38.26;
  static double font26 = screenHeight/34;

  // Icon Size
  static double iconSize24 = screenHeight/36.17;
  static double iconSize16 = screenHeight/55.25;
  static double iconSize30 = screenHeight/29.33;

  //list view size
  static double listViewImgSize = screenWidth/3.6;
  static double listViewTextContSize = screenWidth/4.32;

  // popular item
  static double popularItemImgSize = screenHeight/2.53;
}