import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/pages/auth/sign_up_page.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/app_text_field.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
            // logo
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
            // welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Xin Chào",
                    style: TextStyle(
                      fontSize: Dimensions.font20*3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Hãy đăng nhập tài khoản của bạn",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            // email
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email_outlined),
            SizedBox(height: Dimensions.height20,),
            // password
            AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password),

            SizedBox(height: Dimensions.screenHeight*0.05,),
            // Sign in button
            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.main_Color,
              ),
              child: Center(child: BigText(text: "Đăng Nhập", size: Dimensions.font26, color: Colors.white,)),
            ),

            SizedBox(height: Dimensions.screenHeight*0.05,),
            // Sign up option
            RichText(
                text: const TextSpan(
                    text: "Đăng nhập bằng phương thức khác",
                    style: TextStyle(
                        color: Colors.grey
                    )
                )),
            Wrap(
              children: List.generate(2, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage(
                      "assets/image/" + signUpImage[index]
                  ),
                ),
              )),
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            RichText(
                text: TextSpan(
                    text: "Chưa có tài khoản?",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(() => SignUpPage(), transition: Transition.fadeIn),
                      text: " Tạo tài khoản ngay",
                      style: TextStyle(
                          color: AppColors.mainBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font20
                      ),
                    )
                  ]
                )),
          ],
        ),
      ),
    );
  }
}
