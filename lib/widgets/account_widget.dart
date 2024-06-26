import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';

import 'app_icon.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({super.key, required this.bigText, required this.appIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
    );
  }
}
