import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_flutter/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/controller/location_controller.dart';
import 'package:khoaluan_flutter/models/address_model.dart';
import 'package:khoaluan_flutter/pages/address/pick_address_map.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/app_text_field.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';

import '../../controller/user_controller.dart';
import '../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  // CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
  //   10.8163722, 106.6355253
  // ), zoom: 17);
  // late LatLng _initialPosition = LatLng(
  //     10.8163722, 106.6355253
  // );

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() == "") {
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>().addressList.last
        );
      }

      Get.find<LocationController>().getUserAddress();
      LatLng position = LatLng(Get.find<LocationController>().position.latitude, Get.find<LocationController>().position.longitude);
      _cameraPosition = CameraPosition(target: position, zoom: 17);
      _initialPosition = position;
    } else {
      _cameraPosition = const CameraPosition(target: LatLng(10.8163722, 106.6355253), zoom: 17);
      _initialPosition = LatLng(10.8163722, 106.6355253);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page", style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.main_Color, centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = "${locationController.placemark.name??''}"
              "${locationController.placemark.locality??''}"
              "${locationController.placemark.postalCode??''}"
              "${locationController.placemark.country??''}";
          print("address in my view " + _addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: Dimensions.width10/2, right: Dimensions.width10/2, top: Dimensions.width10/2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2, color: AppColors.main_Color,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                        onTap: (latlng){
                          Get.toNamed(RouteHelper.getPickAddressPage(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,
                            )
                          );
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                        },
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20),
                  child: SizedBox(height: Dimensions.height10*5, child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        locationController.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1, // bán kính trải rộng
                              blurRadius: 5,
                            ),
                          ]
                        ),
                        child: Icon(
                            index == 0 ? Icons.home:index == 1 ? Icons.work:Icons.location_on,
                            color: locationController.addressTypeIndex == index
                                ?AppColors.main_Color
                                :Theme.of(context).disabledColor
                        )
                      ),
                    );
                  }),),
                ),

                // your address
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Địa chỉ giao hàng của bạn"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _addressController, hintText: "Địa chỉ của bạn", icon: Icons.map),
                // your name
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Tên của bạn"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonName, hintText: "Tên của bạn", icon: Icons.person),
                // your phone
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Số điện thoại của bạn"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonNumber, hintText: "Địa chỉ của bạn", icon: Icons.phone_android),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20*5,
              padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString(),
                      );
                      locationController.addAddress(_addressModel).then((response){
                        if(response.isSuccess){
                          Get.toNamed(RouteHelper.getCartPage());
                          Get.snackbar("Thông báo", "Đã thêm địa chỉ thành công");
                        } else {
                          Get.snackbar("Thông báo", "Không thể lưu địa chỉ");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, right: Dimensions.width20, left: Dimensions.width20,),
                      child: BigText(text: "Lưu địa chỉ", color: Colors.white, size: Dimensions.font26,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.main_Color,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
