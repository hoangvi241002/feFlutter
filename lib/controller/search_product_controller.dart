import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/api/api_checker.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';

import '../data/repository/search_product_repo.dart';
import '../models/products_model.dart';
import 'package:http/http.dart' as http;

class SearchProductController extends GetxController {
  final SearchProductRepo searchProductRepo;
  SearchProductController({required this.searchProductRepo});

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }

  List<ProductModel> _searchResults = [];
  List<ProductModel> get searchResults => _searchResults;

  Future<void> searchProducts(String keyword) async {
    setLoading = true;
    try {
      Response response = await searchProductRepo.searchProducts(keyword);
      if(response.statusCode == 200){
        List<dynamic> body = response.body;
        _searchResults = body.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        print("Lỗi ${response.statusText}");
        Get.snackbar("Lỗi", "Không thể tìm kiếm sản phẩm: ${response.statusText}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch(e) {
      Get.snackbar("Lỗi", "Không thể tìm kiếm sản phẩm: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setLoading = false;
      update();
    }
  }
}