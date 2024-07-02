import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart'; // API Client để gọi API từ server
import 'package:khoaluan_flutter/utils/app_constants.dart'; // Các hằng số của ứng dụng

class SearchProductRepo extends GetxService {
  final ApiClient apiClient;

  SearchProductRepo({required this.apiClient});

  Future<Response> searchProducts(String keyword) async {
    return await apiClient.getData('${AppConstants.BASE_URL}/api/v1/products/search?keyword=$keyword'); // Gọi API tìm kiếm
  }
}
