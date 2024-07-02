import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khoaluan_flutter/controller/order_controller.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/utils/styles.dart';

class DeliveryOptions extends StatelessWidget {

  double exchangeRate = 25000;
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

  final String value;
  final String title;
  final double amount;
  final bool isFree;
  DeliveryOptions({super.key,
    required this.value, required this.title,
    required this.amount, required this.isFree
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
      children: [
        Radio(
          value: value,
          groupValue: orderController.orderType,
          onChanged: (String? value) => orderController.setDeliveryType(value!),
          activeColor: Theme.of(context).primaryColor,
        ),
        SizedBox(height: Dimensions.height10,),
        Text(title),
        SizedBox(height: Dimensions.height10,),
        Text(
          '(${(value == 'Đến lấy hàng' || isFree)?'free':'${formatCurrencyVND(amount.toInt() ~/ 40 + 200000)}'})',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20),
        )
      ],
      );
    });
  }
}
