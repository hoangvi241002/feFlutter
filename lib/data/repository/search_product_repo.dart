import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/products_model.dart';
import '../api/api_client.dart';

class SearchProductRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  SearchProductRepo({required this.sharedPreferences, required this.apiClient});

  // Lấy tất cả các sản phẩm từ SharedPreferences
  List<ProductModel> _getAllProducts() {
    List<String> products = sharedPreferences.getStringList(AppConstants.SEARCH_PRODUCT_URI) ?? [];
    return products.map((product) => ProductModel.fromJson(jsonDecode(product))).toList();
  }

  Future<Response> searchProducts(String keyword) async {
    return await apiClient.getData('${AppConstants.SEARCH_PRODUCT_URI}?keyword=$keyword');
  }

  // Tìm kiếm sản phẩm theo từ khóa
  // List<ProductModel> searchProducts(String keyword) {
  //   List<ProductModel> allProducts = _getAllProducts();
  //   return allProducts.where((product) => product.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
  // }
}
