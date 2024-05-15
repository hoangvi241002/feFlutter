import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/base/custom_loader.dart';
import 'package:khoaluan_flutter/base/no_data_page.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:khoaluan_flutter/pages/home/widgets/search_results.dart';
import 'package:khoaluan_flutter/pages/home/widgets/search_widget.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:get/get.dart';
import '../../../utils/dimensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchProductController>(builder: (searchProductController) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: Dimensions.height80,
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white24,
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  child: SearchWidget(
                    controller: _searchController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    hintText: "Nhập sản phẩm cần tìm...",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (_searchController.text.isNotEmpty) {
                          searchProductController.searchProducts(_searchController.text);
                        } else {
                          Get.snackbar("Thông báo", "Vui lòng nhập từ khóa tìm kiếm",
                            backgroundColor: AppColors.main_Color,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Icon(Icons.search, color: AppColors.main_Color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height80),
            child: SafeArea(
              child: searchProductController.isLoading
                  ? const CustomLoader()
                  : searchProductController.searchResults.isEmpty
                  ? const NoDataPage(text: "Không tìm thấy sản phẩm")
                  : const SearchResults(),
            ),
          ),
        ),
      );
    });
  }
}
