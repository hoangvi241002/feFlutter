import 'package:get/get.dart';
import 'package:khoaluan_flutter/models/user_model.dart';
import '../data/repository/user_repo.dart';
import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController ({required this.userRepo});

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future <ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    // print("test" + response.body.toString());
    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      print("did not get");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}