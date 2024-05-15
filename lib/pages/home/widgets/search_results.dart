import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/models/products_model.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchProductController>(builder: (searchProductController) {
      if (searchProductController.searchResults.isEmpty) {
        return const Center(child: Text('Không có kết quả tìm kiếm'));
      }

      return Container(
        padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
        height: Dimensions.screenHeight,
        child: ListView.builder(
          itemCount: searchProductController.searchResults.length,
          itemBuilder: (context, i) {
            ProductModel product = searchProductController.searchResults[i];
            return ListTile(
              title: Text(product.name ?? 'Tên sản phẩm'),
              subtitle: Text(product.description ?? 'Mô tả sản phẩm'),
            );
          },
        ),
      );
    });
  }
}
