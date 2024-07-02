import 'package:get/get.dart';
import 'package:khoaluan_flutter/models/order_model.dart';

import '../data/repository/order_repo.dart';
import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late List<OrderModel> _currentOrderList = [];
  late List<OrderModel> _historyOrderList = [];

  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = "delivery";
  String get orderType => _orderType;

  String _note = " ";
  String get note => _note;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = false;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode == 200){
      _isLoading = false;
      print(response.body.toString());
      String message = response.body['message'];
      String orderID=response.body ['order_id'].toString();
      callback(true, message, orderID);
    } else {
      print('My status code is ' + response.statusCode.toString());
      callback(false, response.statusText!, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode == 200){
      _currentOrderList = [];
      _historyOrderList = [];
      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus == 'pending'||
            orderModel.orderStatus == 'accepted'||
            orderModel.orderStatus == 'processing'||
            orderModel.orderStatus == 'handover'||
            orderModel.orderStatus == 'picked_up'
        ){
          _historyOrderList.add(orderModel);
        } else {
          _currentOrderList.add(orderModel);
        }
      });
    } else {
      _currentOrderList = [];
      _historyOrderList = [];
    }
    _isLoading = false;
    print("The length of the orders current " + _currentOrderList.length.toString());
    print("The length of the orders history " + _historyOrderList.length.toString());
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type){
    _orderType = type;
    update();
  }

  void setNote(String getNote){
    _note = getNote;
    update();
  }
}