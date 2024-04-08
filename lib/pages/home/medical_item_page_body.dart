import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/popular_product_controller.dart';
import 'package:khoaluan_flutter/controller/recommended_product_controller.dart';
import 'package:khoaluan_flutter/pages/medical_item/popular_medical_item_detail.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/app_constants.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/icon_and_text_widget.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

import '../../models/products_model.dart';
import '../../widgets/bonus_icon.dart';
import '../../widgets/icon_and_text_detail.dart';

class MedicalItemPageBody extends StatefulWidget {
  const MedicalItemPageBody({super.key});

  @override
  State<MedicalItemPageBody> createState() => _MedicalPageBodyState();
}

class _MedicalPageBodyState extends State<MedicalItemPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get.find<PopularProductController>().initProduct();
    return Column(
      children: [
        // slider section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded?Container(
            // color: Colors.redAccent,
            height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        // dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        // popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          // color: Colors.redAccent,
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                padding: EdgeInsets.only(bottom: Dimensions.height7),
                child: SmallText(text: "Equipment pairing",),
              )
            ],
          ),
        ),
        //list of equipments and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedMedicalItem(index));
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          // image section
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                    )
                                )
                            ),
                          ),
                          // text section
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white12,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                    SizedBox(height: Dimensions.height10,),
                                    SmallText(text: recommendedProduct.recommendedProductList[index].description!),
                                    SizedBox(height: Dimensions.height10,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),

                                          IconAndTextWidget(icon: Icons.location_on,
                                              text: "1.7Km",
                                              iconColor: AppColors.mainColor),

                                          IconAndTextWidget(icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor1),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                );
              }):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index==_currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale=0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularMedicalItem(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width15, right: Dimensions.width15,),
                child: IconAndTextDetail(text:popularProduct.name!),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
