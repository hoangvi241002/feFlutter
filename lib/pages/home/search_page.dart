import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom_loader.dart';
import 'package:khoaluan_flutter/base/no_data_page.dart';
import 'package:khoaluan_flutter/controller/search_product_controller.dart';
import 'package:khoaluan_flutter/pages/home/widgets/search_widget.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height80,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: EdgeInsets.only(top: Dimensions.height10),
          child: SearchWidget(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: "Tìm kiếm sản phẩm",
            suffixIcon: GestureDetector(
              onTap: (){}, child: Icon(Icons.search_outlined, color: AppColors.main_Color,),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.height80*2),
          child: SafeArea(
              child: NoDataPage(text: "Nhập sản phẩm cần tìm ở trên",)
          ),
        ),
      ),
    );
  }
}
