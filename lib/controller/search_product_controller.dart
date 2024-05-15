import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/repository/search_product_repo.dart';
import 'package:khoaluan_flutter/models/products_model.dart';

class SearchProductController extends GetxController {
  final SearchProductRepo searchProductRepo;
  SearchProductController({required this.searchProductRepo});

  // Danh sách để lưu kết quả tìm kiếm
  List<ProductModel> _searchResults = [];
  List<ProductModel> get searchResults => _searchResults;

  // Biến để lưu trữ từ khóa tìm kiếm hiện tại
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  bool isLoading = false;

  // Phương thức tìm kiếm sản phẩm
  void searchProducts(String query) async {
    _searchQuery = query;
    isLoading = true;
    update();
    try {
      Response response = await searchProductRepo.searchProducts(query);
      if (response.statusCode == 200) {
        List<dynamic> body = response.body;
        _searchResults = body.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        Get.snackbar("Lỗi", "Không thể tìm kiếm sản phẩm: ${response.statusText}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tìm kiếm sản phẩm: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // Phương thức xóa kết quả tìm kiếm
  void clearSearch() {
    _searchResults = [];
    _searchQuery = "";
    update();
  }

  // Phương thức kiểm tra xem sản phẩm có trong kết quả tìm kiếm không
  bool existInSearchResults(ProductModel product) {
    return _searchResults.any((element) => element.id == product.id);
  }

  // Phương thức lấy một kết quả tìm kiếm cụ thể theo chỉ số
  ProductModel getSearchResult(int index) {
    return _searchResults[index];
  }
}