import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

import '../../controller/auth_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';
import 'medical_item_page_body.dart';

class MainMedicalItemPage extends StatefulWidget {
  @override
  _MainMedicalItemPageState createState() => _MainMedicalItemPageState();
}

class _MainMedicalItemPageState extends State<MainMedicalItemPage> {
  // String get keyword => "";

  @override
  void initState() {
    super.initState();
    _loadResource();
    Get.find<LocationController>().getUserAddress();
    // Get.find<SearchProductController>().searchProducts(keyword);
  }

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadResource,
      child: Column(
        children: [
          // Hiển thị tiêu đề
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<LocationController>(builder: (locationController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'Việt Nam',
                        color: AppColors.main_Color
                      ),
                      GestureDetector(
                        onTap: (){
                          if (Get.find<AuthController>().userLoggedIn() || Get.find<LocationController>().hasSavedAddress()) {
                            // Kiểm tra xem người dùng đã đăng nhập hoặc có địa chỉ được lưu
                            Get.toNamed(RouteHelper.getAddressPage());
                          } else {
                            Get.snackbar("Thông Báo", "Bạn cần đăng nhập để thêm địa chỉ",
                                backgroundColor: AppColors.main_Color,
                                colorText: Colors.white,
                            );
                          }
                        } ,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10/2),
                              child: Text(
                                locationController.placemark.name ?? 'Chưa thêm địa chỉ',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: Dimensions.font12
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getSearchPage());
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.search_outlined,
                          backgroundColor: AppColors.main_Color,
                          iconColor: Colors.white,
                          iconSize: Dimensions.font26,
                          size: Dimensions.font26 * 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Hiển thị nội dung chính
          const Expanded(
            child: SingleChildScrollView(
              child: MedicalItemPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
