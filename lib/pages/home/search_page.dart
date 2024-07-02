import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';
import '../../data/repository/search_product_repo.dart';
import '../../models/products_model.dart';

class SearchPage extends StatelessWidget {
  final SearchProductRepo searchProductRepo;

  SearchPage({required this.searchProductRepo});

  @override
  Widget build(BuildContext context) {
    final SearchProductController searchProductController = SearchProductController(searchProductRepo: searchProductRepo);

    return Scaffold(
      appBar: AppBar(
        title: Container(padding: EdgeInsets.only(left: Dimensions.width45),child: Text('Tìm kiếm sản phẩm', style: TextStyle(color: Colors.white),)),
        backgroundColor: AppColors.main_Color,
      ),
      body: Column(
        children: [
          // Widget để nhập từ khóa tìm kiếm
          Container(
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.height10),
            child: TextField(
              onChanged: (value) => searchProductController.search(value), // Gọi hàm tìm kiếm khi thay đổi nội dung ô nhập liệu
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa sản phẩm cần tìm',
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                    margin: EdgeInsets.only(bottom: Dimensions.height10/2),
                    child: BigText(text: "Tìm kiếm", color: Colors.white, size: Dimensions.font16,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                      color: AppColors.main_Color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Widget hiển thị kết quả tìm kiếm
          Expanded(
            child: Obx(() {
              if (searchProductController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                // Kiểm tra xem có kết quả tìm kiếm không
                if (searchProductController.products.isEmpty) {
                  return Center(child: Text('Không tìm thấy sản phẩm'));
                } else {
                  // Hiển thị danh sách sản phẩm tìm kiếm
                  return ListView.builder(
                    itemCount: searchProductController.products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = searchProductController.products[index];
                      return ListTile(
                        title: Text(product.name ?? ''),
                        subtitle: Text('Giá: ${product.price ?? 0}'),
                        onTap: () {},
                      );
                    },
                  );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
