import 'package:flutter_mvvm_architecture_a_z/service/web_service.dart';
import '../model/user_model.dart';

class UserViewModel{
  final _service = WebService();

  Future<List<UserModel>> fetchUsers() async{
    return await _service.getUser();
  }
}