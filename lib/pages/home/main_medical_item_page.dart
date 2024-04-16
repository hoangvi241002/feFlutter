import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

import 'medical_item_page_body.dart';

class MainMedicalItemPage extends StatefulWidget {
  const MainMedicalItemPage({super.key});

  @override
  State<MainMedicalItemPage> createState() => _MainMedicalItemPageState();
}

class _MainMedicalItemPageState extends State<MainMedicalItemPage> {
  @override
  Widget build(BuildContext context) {
    // print("Current width is "+MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          // Showing The Header
          Container(
            child: Container(
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
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10,),
                                child: Row(
                                  children: [
                                    SmallText(text: "Hồ Chí Minh", color: Colors.black54,),
                                    Icon(Icons.arrow_drop_down_rounded)
                                  ],
                                ),
                              ),
                            )

                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.main_Color,
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ),
          // Showing The Body
          Expanded(child: SingleChildScrollView(
            child: MedicalItemPageBody(),
          )),
        ],
      ),
    );
  }
}
