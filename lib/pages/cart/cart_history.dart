import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khoaluan_flutter/base/no_data_page.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/models/cart_model.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/app_icon.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';

import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for(int i = 0; i < getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) =>++ value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate, size: Dimensions.font16,);

    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.main_Color,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.main_Color, backgroundColor: Colors.white,),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?
            Expanded(child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20, right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // định dạng lại thời gian đặt hàng
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                        direction: Axis.horizontal, // cho hình ảnh nằm ngang cùng 1 hàng
                                        children: List.generate(itemsPerOrder[i], (index) {
                                          if(listCounter < getCartHistoryList.length){
                                            listCounter++;
                                          }
                                          return index<=2?Container(
                                            height: Dimensions.height80,
                                            width: Dimensions.width80,
                                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[listCounter-1].img!
                                                    )
                                                )
                                            ),
                                          ):Container();
                                        })
                                    ),
                                    Container(
                                      height: Dimensions.height80,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "Total", color: AppColors.titleColor,),
                                          BigText(text: "${itemsPerOrder[i]} Products", color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder = {};
                                              for(int j=0; j<getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].time==orderTime[i]){
                                                  // print("My order time is " + orderTime[i]);
                                                  // print("My order id is " + getCartHistoryList[j].id.toString());
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!,
                                                          () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                border: Border.all(width: 1, color: AppColors.main_Color),
                                              ),
                                              child: SmallText(text: "one more", color: AppColors.main_Color,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  )
              ),):
            Container(
              height: MediaQuery.of(context).size.height/1.5,
              child: const Center(
                child: NoDataPage(
                  text: "You didn't buy anything so far",
                  imgPath: "assets/image/empty-box.png",),
              )
            );
          })
        ],
      ),
    );
  }
}
