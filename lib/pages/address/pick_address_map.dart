import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/base/custom.button.dart';
import 'package:khoaluan_flutter/controller/location_controller.dart';
import 'package:khoaluan_flutter/pages/address/widgets/search_location_page.dart';
import 'package:khoaluan_flutter/routes/route_helper.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({super.key, required this.fromSignup, required this.fromAddress, this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(10.8163752, 106.6355243);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"])
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialPosition, zoom: 17
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                      if(!widget.fromAddress){
                        print("pick from web");
                      }
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ?Image.asset("assets/image/pick-location (1).png",
                          height: Dimensions.height10*5,
                          width: Dimensions.width10*5,
                        )
                        :CircularProgressIndicator()
                  ),

                  // Show and select address
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: () => Get.dialog(SearchLocationPage(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          color: AppColors.main_Color,
                          borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.yellowColor, size: Dimensions.font26,),
                            Expanded(child: Text(
                              '${locationController.pickPlacemark.name??''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                           Icon(Icons.search, color: Colors.white, size: Dimensions.font26,),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height80,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: CustomButton(
                      width: Dimensions.screenWidth/2,
                      buttonText: "Chọn địa chỉ này",
                      onPressed: locationController.loading?null:(){
                        if(locationController.pickPosition.latitude!=0
                            && locationController.pickPlacemark.name!=null){
                          if(widget.fromAddress){
                            if(widget.googleMapController!=null){
                              print("you can choose on this");
                              widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(
                                  locationController.pickPosition.latitude,
                                  locationController.pickPosition.longitude
                              ))));
                              locationController.setAddAddressData();
                              print("update data");
                            }
                            Get.toNamed(RouteHelper.getAddressPage());
                          }
                        }
                      },
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
