import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom_button.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  OrderSuccessPage({super.key, required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(const Duration(seconds: 1), () {

      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(status == 1 ? Icons.check_circle_outline : Icons.warning_amber_outlined,
                size: Dimensions.width20*5, color: AppColors.iconColor3,
              ),
              SizedBox(height: Dimensions.height30,),

              Text(
                status == 1 ? 'Đơn hàng của bạn đã được đặt thành công' : 'Đặt hàng thất bại',
                style: TextStyle(fontSize: Dimensions.font20),
              ),
              SizedBox(height: Dimensions.height20,),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10
                ),
                child: Text(
                  status == 1 ? 'Đặt hàng thành công' : 'Đơn hàng đã đặt thất bại',
                  style: TextStyle(fontSize: Dimensions.font20, color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: CustomButton(
                  buttonText: 'Quay lại trang chủ',
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              )
            ]))),
    );
  }
}
