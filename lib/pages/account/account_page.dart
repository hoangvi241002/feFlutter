import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom_loader.dart';
import 'package:khoaluan_flutter/controller/auth_controller.dart';
import 'package:khoaluan_flutter/controller/cart_controller.dart';
import 'package:khoaluan_flutter/controller/location_controller.dart';
import 'package:khoaluan_flutter/controller/user_controller.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("You has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main_Color,
        title: Center(child: BigText(text: "Thông tin cá nhân", size: Dimensions.font26, color: Colors.white,)),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn
            ?(userController.isLoading
              ?Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: Dimensions.height20),
                child: Column(
                  children: [
                    // profile icon
                    AppIcon(
                      icon: Icons.person,
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
                              bigText: BigText(text: userController.userModel!.name),
                              appIcon: AppIcon(
                                icon: Icons.person,
                                backgroundColor: AppColors.main_Color,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                size: Dimensions.height10*5,
                              ),
                            ),
                            SizedBox(height: Dimensions.height20,),
                            // phone
                            AccountWidget(
                              bigText: BigText(text: userController.userModel!.phone),
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
                              bigText: BigText(text: userController.userModel!.email),
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
                            GetBuilder<LocationController>(builder: (locationController){
                              if(_userLoggedIn&&locationController.addressList.isEmpty){
                                return GestureDetector(
                                  onTap: (){
                                    Get.offNamed(RouteHelper.getAddressPage());
                                  },
                                  child: AccountWidget(
                                    bigText: BigText(text: "Thêm địa chỉ",),
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      backgroundColor: AppColors.main_Color,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10*5/2,
                                      size: Dimensions.height10*5,
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: (){
                                    Get.offNamed(RouteHelper.getAddressPage());
                                  },
                                  child: AccountWidget(
                                    bigText: BigText(text: "Xem lại địa chỉ của bạn",),
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      backgroundColor: AppColors.main_Color,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10*5/2,
                                      size: Dimensions.height10*5,
                                    ),
                                  ),
                                );
                              }
                            }),
                            SizedBox(height: Dimensions.height20,),
                            // message
                            AccountWidget(
                              bigText: BigText(text: "Liên hệ",),
                              appIcon: AppIcon(
                                icon: Icons.message,
                                backgroundColor: AppColors.main_Color,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                size: Dimensions.height10*5,
                              ),
                            ),
                            SizedBox(height: Dimensions.height20,),
                            // log out
                            GestureDetector(
                              onTap: (){
                                if(Get.find<AuthController>().userLoggedIn()){
                                  Get.find<AuthController>().clearSharedData();
                                  Get.find<CartController>().clear();
                                  Get.find<CartController>().clearCartHistory();
                                  Get.find<LocationController>().clearAddressList();
                                  Get.offNamed(RouteHelper.getSignInPage());
                                } else {
                                  print("You logged out");
                                }
                              },
                              child: AccountWidget(
                                bigText: BigText(text: "Đăng Xuất",),
                                appIcon: AppIcon(
                                  icon: Icons.logout,
                                  backgroundColor: AppColors.iconColor3,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  size: Dimensions.height10*5,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.height20,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
              :CustomLoader())
            :Container(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: double.maxFinite,
                          height: Dimensions.height30*8,
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/image/logo1.png",
                              )
                            )
                          ),
                       ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20*5,
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.main_Color,
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                          ),
                          child: Center(child: BigText(text: "Login Now", color: Colors.white,)),
                        ),
                      ),
                    ],
            )
           )
        ,);
      }),
    );
  }
}
