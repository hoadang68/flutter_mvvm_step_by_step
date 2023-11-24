import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture_a_z/api/api_response.dart';
import 'package:flutter_mvvm_architecture_a_z/repository/repository.dart';
import '../model/user_model.dart';

class UserViewModel extends ChangeNotifier{
  ApiResponse _apiResponse = ApiResponse.initial("Loading");
  final _repository = Repository();
  ApiResponse get apiResponse => _apiResponse;
  Future<void> fetchUsers() async{
    List<UserModel> users = await _repository.getListUser();
    _apiResponse = ApiResponse.complete(users);
    notifyListeners();
  }
}
