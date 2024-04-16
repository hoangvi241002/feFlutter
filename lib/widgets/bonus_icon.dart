import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/popular_product_controller.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class BonusIcon extends StatelessWidget {
  const BonusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width20, left: Dimensions.width20,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: Colors.white,
      ),
      child: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Row(
          children: [
            GestureDetector(
                onTap: (){
                  popularProduct.setQuantity(false);
                },
                child: Icon(Icons.remove, color: AppColors.signColor, size: Dimensions.height15,)),
              SizedBox(width: Dimensions.width10/2,),
              BigText(text: popularProduct.inCartItems.toString(), size: Dimensions.height20,),
              SizedBox(width: Dimensions.width10/2,),
              GestureDetector(
                  onTap: (){
                    popularProduct.setQuantity(true);
                  },
                  child: Icon(Icons.add, color: AppColors.signColor, size: Dimensions.height15,)),
          ],
        );
      }),
    );
  }
}
