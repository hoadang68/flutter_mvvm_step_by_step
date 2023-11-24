import 'package:flutter_mvvm_architecture_a_z/model/user_model.dart';
import 'package:flutter_mvvm_architecture_a_z/service/web_service.dart';

class Repository{
  final WebService webService = WebService();
  List<UserModel> _user = [];

  Future<List<UserModel>> getListUser() async {
    try {
      dynamic response = await webService.getResponse();
      final List result = response.data['data'] as List;
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } catch (e) {
      throw e;
    }
  }
}