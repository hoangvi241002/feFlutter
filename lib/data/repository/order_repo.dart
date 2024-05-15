import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';

import '../../models/place_order_model.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}