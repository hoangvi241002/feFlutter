import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khoaluan_flutter/pages/home/widgets/search_page.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import 'medical_item_page_body.dart';

class MainMedicalItemPage extends StatefulWidget {
  const MainMedicalItemPage({super.key});

  @override
  State<MainMedicalItemPage> createState() => _MainMedicalItemPageState();
}

class _MainMedicalItemPageState extends State<MainMedicalItemPage> {

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    // print("Current width is "+MediaQuery.of(context).size.width.toString());
    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(
          children: [
            // Showing The Header
            Container(
              margin: EdgeInsets.only(top:Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Việt Nam", color: AppColors.main_Color,),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10,),
                              child: Row(
                                children: [
                                  SmallText(text: "Hồ Chí Minh", color: Colors.black54,),
                                  const Icon(Icons.arrow_drop_down_rounded)
                                ],
                              ),
                            )

                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.offNamed(RouteHelper.getSearchPage());
                      },
                      child: Center(
                        child: Container(
                          width: Dimensions.width45,
                          height: Dimensions.height45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.main_Color,
                          ),
                          child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            // Showing The Body
            const Expanded(child: SingleChildScrollView(
              child: MedicalItemPageBody(),
            )),
          ],
        )
    );
  }
}
