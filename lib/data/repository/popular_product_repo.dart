import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future <Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

  Future<Response> searchProducts(String keyword) async {
    return await apiClient.getData('${AppConstants.SEARCH_PRODUCT_URI}?keyword=$keyword');
  }
}