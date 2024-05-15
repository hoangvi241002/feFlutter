import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khoaluan_flutter/base/custom_text.dart';
import 'package:khoaluan_flutter/base/no_data_page.dart';
import 'package:khoaluan_flutter/base/show_custom_snackbar.dart';
import 'package:khoaluan_flutter/controller/auth_controller.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/controller/location_controller.dart';
import 'package:khoaluan_flutter/controller/order_controller.dart';
import 'package:khoaluan_flutter/controller/popular_product_controller.dart';
import 'package:khoaluan_flutter/controller/user_controller.dart';
import 'package:khoaluan_flutter/pages/cart/cart_history.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/pages/order/delivery_options.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/app_icon.dart';
import 'package:khoaluan_flutter/widgets/app_text_field.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

import '../../controller/recommended_product_controller.dart';
import '../../models/place_order_model.dart';
import '../../widgets/bonus_icon.dart';
import '../order/payment_option_button.dart';

class CartPage extends StatelessWidget {

  double exchangeRate = 25500;
  double convertCurrencyVNDtoUSD(int vndAmount) {
    return vndAmount / exchangeRate;
  }

  String formatCurrencyVND(int number) {
    final format = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );
    return format.format(number);
  }

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20, right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: AppIcon(icon: Icons.arrow_back,
                    iconColor: Colors.white,
                      backgroundColor: AppColors.main_Color,
                      iconSize: Dimensions.font20,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20*6,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.main_Color,
                      iconSize: Dimensions.font20,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.main_Color,
                      iconSize: Dimensions.font20,
                    ),
                ],
          )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?
            Positioned(
                top: Dimensions.height20*5, bottom: 0,
                left: Dimensions.width20, right: Dimensions.width20,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20*5,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularMedicalItem(popularIndex, "cartpage"));
                                      } else {
                                        var recommendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar("Thông Báo", "Không tìm thấy sản phẩm từ lịch sử đặt hàng!",
                                            backgroundColor: AppColors.iconColor3,
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.toNamed(RouteHelper.getRecommendedMedicalItem(recommendedIndex, "cartpage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.height20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(
                                      child: Container(
                                        height: Dimensions.height20*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                            SmallText(text: "đừng mua"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: formatCurrencyVND(cartController.getItems[index].price!), color: Colors.redAccent, size: Dimensions.font20,),
                                                Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, right: Dimensions.width20, left: Dimensions.width20,),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: (){
                                                            cartController.addItem(_cartList[index].product!, -1);
                                                          },
                                                          child: Icon(Icons.remove, color: AppColors.signColor, size: Dimensions.height15,)),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      BigText(text: _cartList[index].quantity.toString(), size: Dimensions.height20,),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            cartController.addItem(_cartList[index].product!, 1);
                                                          },
                                                          child: Icon(Icons.add, color: AppColors.signColor, size: Dimensions.height15,)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    },),
                  ),
                )):
            NoDataPage(text: "Your Cart Is Empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
        _noteController.text = orderController.note;
        return GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.bottomPagePopular+40,
            padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: cartController.getItems.length>0?Column(
              children: [
                InkWell(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_){
                      return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(Dimensions.radius20),
                                          topRight: Radius.circular(Dimensions.radius20)
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 520,
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20,
                                            top: Dimensions.height20
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const PaymentOptionButton(
                                              icon: Icons.money,
                                              title: 'Trả tiền mặt',
                                              subtitle: 'Thanh toán sau khi nhận hàng',
                                              index: 0,
                                            ),
                                            SizedBox(height: Dimensions.height10,),
                                            const PaymentOptionButton(
                                              icon: Icons.paypal_outlined,
                                              title: 'Ví điện tử',
                                              subtitle: 'Thanh toán ngay',
                                              index: 1,
                                            ),
                                            SizedBox(height: Dimensions.height20,),
                                            Text("Chọn cách nhận hàng",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font26),
                                            ),
                                            DeliveryOptions(
                                                value: "Delivery", title: "Giao đến nhà ",
                                                amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                                isFree: false
                                            ),
                                            SizedBox(height: Dimensions.height10/2,),
                                            DeliveryOptions(
                                                value: "take away", title: "Đến lấy hàng ",
                                                amount: 0.0, isFree: true
                                            ),
                                            SizedBox(height: Dimensions.height20,),
                                            Text("Ghi chú",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font26),
                                            ),
                                            AppTextField(
                                              textController: _noteController,
                                              hintText: '', icon: Icons.note_alt_outlined,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                      );
                    },
                  ).whenComplete(() => orderController.setNote(_noteController.text.trim())),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CustomText(text: "Phương thức thanh toán",),
                  ),
                ),
                SizedBox(height: Dimensions.height10/2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width10, left: Dimensions.width10,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.width10/2,),
                          BigText(
                            text: formatCurrencyVND(cartController.totalAmount),
                            size: Dimensions.height20,
                          ),
                          SizedBox(width: Dimensions.width10/2,),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width35, left: Dimensions.width35,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.main_Color,
                      ),
                      child: GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().userLoggedIn()){

                              if(Get.find<LocationController>().addressList.isEmpty){
                                Get.toNamed(RouteHelper.getAddressPage());
                              } else {
                                // cartController.addToHistory();
                                var location = Get.find<LocationController>().getUserAddress();
                                var cart = Get.find<CartController>().getItems;
                                var user = Get.find<UserController>().userModel;
                                PlaceOrderBody placeOrder = PlaceOrderBody(
                                  cart:cart,
                                  orderAmount: cartController.totalAmount.toDouble(),
                                  orderNote: orderController.note,
                                  address: location.address,
                                  latitude: location.latitude,
                                  longitude: location.longitude,
                                  contactPersonNumber: user!.phone,
                                  contactPersonName: user.name,
                                  scheduleAt: 'hello',
                                  distance: 10.0,
                                  orderType: orderController.orderType,
                                  paymentMethod: orderController.paymentIndex == 0 ? 'cash_on_delivery' : 'digital_payment',
                                );
                                // print(placeOrder.toJson());
                                // return;
                                Get.find<OrderController>().placeOrder(
                                    placeOrder,
                                    _callback
                                );
                                // Get.offNamed(RouteHelper.getPaymentPage("100001", Get.find<UserController>().userModel.id));
                              }
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: BigText(text: "Thanh Toán", color: Colors.white, size: Dimensions.font20,)
                      ),
                    ),
                  ],
                ),
              ],
            ):Container(),
          );
        },);
      })
    );
  }

  void _callback(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex == 0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "Success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(orderID,
            Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
