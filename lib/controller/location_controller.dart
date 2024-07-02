import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_flutter/data/api/api_checker.dart';
import 'package:khoaluan_flutter/data/repository/location_repo.dart';
import 'package:khoaluan_flutter/models/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  // save the gg map suggestion for address
  List<Prediction> _predictionList = [];

  // Thêm một phương thức để kiểm tra xem có địa chỉ nào được lưu hay không
  bool hasSavedAddress() {
    return placemark.name != null;
  }

  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _loading = true;
      update();
      try {
        if(fromAddress){
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1,
          );
        }

        if(_changeAddress){
          String _address = await getAddressFromGeocode(
            LatLng(
                position.target.latitude,
                position.target.longitude
            )
          );
          fromAddress?_placemark=Placemark(name: _address):_pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch(e){
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }
  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String address = 'Unknown location found';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        // Lấy chi tiết từng thành phần của địa chỉ
        String street = placemark.street ?? '';
        // String subThoroughfare = placemark.subThoroughfare ?? '';
        // String locality = placemark.locality ?? '';
        String administrativeArea = placemark.administrativeArea ?? '';
        // String country = placemark.country ?? '';

        // Build the full address string
        address = '$street, $administrativeArea';
      } else {
        print('Error getting geocode');
      }
    } catch (e) {
      print('Error getting geocode: $e');
    }
    update();
    return address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    // chuyển đổi sang map bằng cách dùng jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch(e){
      print(e);
    }
    return _addressModel;
  }

  // Hàm lấy thành phố từ tọa độ địa lý
  Future<String> getCityFromGeocode(LatLng latLng) async {
    String city = 'Unknown city';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        city = placemark.subAdministrativeArea ?? 'Unknown city';
      }
    } catch (e) {
      print("Error getting city from geocode: $e");
    }
    return city;
  }

  // Hàm lấy quốc gia từ tọa độ địa lý
  Future<String> getCountryFromGeocode(LatLng latLng) async {
    String country = 'Unknown country';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        country = placemark.country ?? 'Unknown country';
      }
    } catch (e) {
      print("Error getting country from geocode: $e");
    }
    return country;
  }

  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  void setAddressTypeIndex(int index){
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel>addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("couldn't save address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if(response.statusCode == 200){
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address){
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList(){
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty){
      Response response = await locationRepo.searchLocation(text);
      if(response.statusCode == 200 && response.body['status'] == 'OK'){
        _predictionList = [];
        response.body['predictions'].forEach((prediction) => _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
      latitude : detail.result.geometry!.location.lat,
      longitude : detail.result.geometry!.location.lng,
      timestamp: DateTime.now(),
      accuracy: 1 ,altitude: 1, heading: 1, altitudeAccuracy: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1,
    );
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if(!mapController.isNull){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(
            detail.result.geometry!.location.lat,
            detail.result.geometry!.location.lng,
          ), zoom: 17)
      ));
    }
    _loading = false;
    update();
  }
}