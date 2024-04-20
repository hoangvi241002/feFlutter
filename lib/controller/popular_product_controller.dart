import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/data/repository/popular_product_repo.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({ required this.popularProductRepo });
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems=0;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      // print("got product");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {

    }
  }

  // chỉnh sửa tăng giảm số lượng
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Thông Báo", "Đây là mức tối thiểu rồi!",
        backgroundColor: AppColors.main_Color,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems+quantity)>10){
      Get.snackbar("Thông Báo", "Đây là mức tối đa rồi!",
        backgroundColor: AppColors.main_Color,
        colorText: Colors.white,
      );
      return 10;
    } else {
      return quantity;
    }
  }

  // check số lượng sp thêm vào giỏ hàng
  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0; // if exist, get from storage _inCartItems=3
    _cart=cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist or not"+exist.toString()); // để check xem sản phẩm đã có trong giỏ hàng chưa
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductModel product ){
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) { 
        print("The id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
      });

      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}