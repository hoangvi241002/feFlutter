import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:khoaluan_flutter/controller/popular_product_controller.dart';
import 'package:khoaluan_flutter/pages/home/main_medical_item_page.dart';
import 'package:khoaluan_flutter/pages/home/medical_item_page_body.dart';
import 'package:khoaluan_flutter/pages/medical_item/popular_medical_item_detail.dart';
import 'package:khoaluan_flutter/pages/medical_item/recommended_medical_item_detail.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'controller/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainMedicalItemPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
