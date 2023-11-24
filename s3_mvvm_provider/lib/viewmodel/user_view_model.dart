import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture_a_z/service/web_service.dart';
import '../model/user_model.dart';

class UserViewModel extends ChangeNotifier{
  final _service = WebService();
  List<UserModel> _users = [];

  Future<void> fetchUsers() async{
    _users = await _service.getUser();
    notifyListeners();
  }
  List<UserModel> getListUser(){
    return _users;
  }

}