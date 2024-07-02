import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom_loader.dart';
import 'package:khoaluan_flutter/controller/order_controller.dart';
import 'package:khoaluan_flutter/models/order_model.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import '../../controller/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class ViewOrder extends StatefulWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  late OrderController orderController;
  Map<String, int> cartItemsPerOrder = {};
  late List<int> itemsPerOrder;

  @override
  void initState() {
    super.initState();
    orderController = Get.find<OrderController>();
    orderController.getOrderList();

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    itemsPerOrder = cartItemsPerOrder.entries.map((e) => e.value).toList();
  }

  List<String> cartOrderTimeToList() {
    return cartItemsPerOrder.entries.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (!orderController.isLoading) {
          List<OrderModel> orderList = [];
          if (orderController.currentOrderList.isNotEmpty || orderController.historyOrderList.isNotEmpty) {
            orderList = widget.isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    var orderTime = cartOrderTimeToList();
                    Map<int, CartModel> moreOrder = {};
                    for (int j = 0; j < Get.find<CartController>().getCartHistoryList().length; j++) {
                      if (Get.find<CartController>().getCartHistoryList()[j].time == orderTime[index]) {
                        moreOrder.putIfAbsent(
                          Get.find<CartController>().getCartHistoryList()[j].id!,
                              () => CartModel.fromJson(jsonDecode(jsonEncode(Get.find<CartController>().getCartHistoryList()[j]))),
                        );
                      }
                    }
                    Get.find<CartController>().setItems = moreOrder;
                    Get.find<CartController>().addToCartList();
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: ${orderList[index].id}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Order Note: ${orderList[index].orderNote ?? 'No Note'}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.main_Color,
                                borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height10 / 2,
                              ),
                              margin: EdgeInsets.all(Dimensions.height10 / 2),
                              child: Text(
                                '${orderList[index].orderStatus}',
                                style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.height10 / 2),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                  vertical: Dimensions.height10 / 2,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                                  border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(Dimensions.height10 / 3),
                                  child: Text(
                                    "Track order",
                                    style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CustomLoader());
        }
      }),
    );
  }
}
