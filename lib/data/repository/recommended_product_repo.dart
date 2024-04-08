import 'package:get/get.dart';
import 'package:khoaluan_flutter/data/api/api_client.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future <Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}