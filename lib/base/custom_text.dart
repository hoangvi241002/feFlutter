import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/big_text.dart';

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width35, left: Dimensions.width35,),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 5,
              color: AppColors.main_Color.withOpacity(0.3),
            )
          ],
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.main_Color,),
        child: Center(child: BigText(text: text, color: Colors.white, size: Dimensions.font20,))
    );
  }
}
