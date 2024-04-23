import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/app_text_field.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "f2.png",
      "g.png"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Dimensions.radius20*4,
                  backgroundImage: const AssetImage(
                    "assets/image/logo1.png"
                  ),
                ),
              ),
            ),
            // email
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email_outlined),
            SizedBox(height: Dimensions.height20,),
            // password
            AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password),
            SizedBox(height: Dimensions.height20,),
            // name
            AppTextField(textController: nameController, hintText: "Tên", icon: Icons.person),
            SizedBox(height: Dimensions.height20,),
            // phone
            AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone_android),
            SizedBox(height: Dimensions.height20,),

            // Sign up button
            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.main_Color,
              ),
              child: Center(child: BigText(text: "Đăng Kí", size: Dimensions.font26, color: Colors.white,)),
            ),
            SizedBox(height: Dimensions.height10,),
            // Tag line
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Bạn đã có tài khoản?",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: Dimensions.font20
                )
            )),
          ],
        ),
      ),
    );
  }
}
