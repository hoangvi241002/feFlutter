import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom_loader.dart';
import 'package:khoaluan_flutter/controller/order_controller.dart';
import 'package:khoaluan_flutter/models/order_model.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/utils/styles.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading == true){
          late List<OrderModel> orderList;
          if(orderController.currentOrderList.isNotEmpty){
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.width10),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Order id: ", style: TextStyle(fontSize: Dimensions.font12,),),
                                    SizedBox(height: Dimensions.height10,),
                                    Text("#${orderList[index].id.toString()}")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.main_Color,
                                        borderRadius: BorderRadius.circular(Dimensions.radius20/4)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                          vertical: Dimensions.height10/2),
                                      margin: EdgeInsets.all(Dimensions.height10/2),
                                      child: Text('${orderList[index].orderStatus}',
                                      style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        color: Colors.white,),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10/2,),
                                    InkWell(
                                      onTap: () => null,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                            vertical: Dimensions.height10/2),
                                          decoration: BoxDecoration(
                                          color: AppColors.main_Color,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(Dimensions.height10/2),
                                            child: Text("Track order",
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                                color: Theme.of(context).primaryColor
                                            ),)
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height10,),
                        ],
                      ),
                    );
                  }),
            )
          );
        } else {
          return CustomLoader();
        }
      }),
    );
  }
}
