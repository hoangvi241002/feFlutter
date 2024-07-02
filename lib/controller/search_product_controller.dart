import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/repository/search_product_repo.dart';
import 'package:khoaluan_flutter/models/products_model.dart';

import '../models/search_model.dart';

class SearchProductController extends GetxController {
  final SearchProductRepo searchProductRepo;
  SearchProductController({required this.searchProductRepo});

  RxBool isLoading = false.obs; // Biến để kiểm tra trạng thái loading
  RxList<ProductModel> products = <ProductModel>[].obs; // Danh sách sản phẩm tìm kiếm
  RxString searchKeyword = ''.obs;

  void search(String keyword) async {
    isLoading.value = true; // Bắt đầu loading
    try {
      var response = await searchProductRepo.searchProducts(keyword); // Gọi API tìm kiếm
      if (response.statusCode == 200) {
        products.value = Product.fromJson(response.body).products; // Lưu kết quả vào danh sách sản phẩm
      } else {
        products.clear(); // Xóa danh sách nếu không có kết quả
      }
    } catch (e) {
      print('Error searching products: $e');
      products.clear(); // Xóa danh sách nếu có lỗi xảy ra
    } finally {
      isLoading.value = false; // Kết thúc loading
    }
  }
}
