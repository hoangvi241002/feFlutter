import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/account_widget.dart';
import 'package:khoaluan_flutter/widgets/app_icon.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/expandable_text_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main_Color,
        title: Center(child: BigText(text: "Profile", size: Dimensions.font26, color: Colors.white,)),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            // profile icon
            AppIcon(
              icon: Icons.person_add_alt_1,
              backgroundColor: AppColors.main_Color,
              iconColor: Colors.white,
              iconSize: Dimensions.iconSize75,
              size: Dimensions.iconSize150,
            ),
            SizedBox(height: Dimensions.height30,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // name
                    AccountWidget(
                      bigText: BigText(text: "Hoàng Vĩ",),
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.main_Color,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    // gender
                    AccountWidget(
                      bigText: BigText(text: "Nam",),
                      appIcon: AppIcon(
                        icon: Icons.accessibility,
                        backgroundColor: AppColors.main_Color,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    // phone
                    AccountWidget(
                      bigText: BigText(text: "0766552858",),
                      appIcon: AppIcon(
                        icon: Icons.phone_android,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    // email
                    AccountWidget(
                      bigText: BigText(text: "hoangvi080@gmail.com",),
                      appIcon: AppIcon(
                        icon: Icons.email_outlined,
                        backgroundColor: AppColors.iconColor2,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    // address
                    AccountWidget(
                      bigText: BigText(text: "133/1/4 Phạm Văn Bạch",),
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: AppColors.main_Color,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    // message
                    AccountWidget(
                      bigText: BigText(text: "Hello",),
                      appIcon: AppIcon(
                        icon: Icons.message,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
