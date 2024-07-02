import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/controller/popular_product_controller.dart';
import 'package:khoaluan_flutter/pages/cart/cart_page.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:khoaluan_flutter/widgets/app_icon.dart';
import 'package:khoaluan_flutter/widgets/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/bonus_icon.dart';
import '../../widgets/icon_and_text_detail.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularMedicalItemDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularMedicalItemDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularItemImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                  )
                )
              ),
          )),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
             left: Dimensions.width20,
             right: Dimensions.width20,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                   onTap: (){
                     if(page=='cartpage'){
                       Get.toNamed(RouteHelper.getCartPage());
                     } else {
                       Get.toNamed(RouteHelper.getInitial());
                     }
                   },
                   child:
                    AppIcon(icon: Icons.arrow_back, backgroundColor: Colors.transparent, iconColor: AppColors.main_Color, iconSize: Dimensions.font23,)),

                 GetBuilder<PopularProductController>(builder: (controller){
                   return GestureDetector(
                     onTap: (){
                       if(controller.totalItems >= 0)
                        Get.toNamed(RouteHelper.getCartPage());
                     },
                     child: Stack(
                       children: [
                         AppIcon(icon: Icons.shopping_cart_outlined, backgroundColor: Colors.transparent, iconColor: AppColors.main_Color, iconSize: Dimensions.font23,),
                         Get.find<PopularProductController>().totalItems >= 1?
                            Positioned(
                              right:0, top:0,
                                child: AppIcon(icon: Icons.circle, size: Dimensions.font20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.main_Color,),
                            ):
                                Container(),
                         Get.find<PopularProductController>().totalItems >= 1?
                         Positioned(
                           right: 5, top:2,
                           child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                              size: Dimensions.font12, color: Colors.white,
                           ),
                         ):
                         Container(),
                       ],
                     ),
                   );
                 })
               ],
          )),
          //intro of food
          Positioned(
             left: 0,
             right: 0,
             bottom: 0,
             top: Dimensions.popularItemImgSize-20,
             child: Container(
               padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20,),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                   topRight: Radius.circular(Dimensions.radius20),
                   topLeft: Radius.circular(Dimensions.radius20)
                 ),
                 color: Colors.white
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   IconAndTextDetail(text: product.name!),
                   SizedBox(height: Dimensions.height20,),
                   BigText(text: "Introduce"),
                   SizedBox(height: Dimensions.height20,),
                   Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!)))
                 ],
               ),
          )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomPagePopular,
          padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BonusIcon(),
              Container(
                padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width20, left: Dimensions.width20,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.main_Color,
                ),
                child: GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: BigText(text: "${product.price!} | Thêm giỏ hàng", color: Colors.white, size: Dimensions.font20,)),
              ),
            ],
          ),
        );
      },)
    );
  }
}
