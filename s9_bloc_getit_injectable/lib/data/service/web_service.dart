import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../model/user_model.dart';

@Injectable()
class WebService {

  String endpoint = 'https://reqres.in/api/users?page=1';

  Future<List<UserModel>> getUser() async {
    final Dio dio = Dio();
    Response response = await dio.get(endpoint);
    if (response.statusCode == 200) {
      final List result = response.data['data'] as List;
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
}