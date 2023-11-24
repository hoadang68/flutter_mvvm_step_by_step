import 'package:injectable/injectable.dart';
import '../model/user_model.dart';
import '../service/web_service.dart';

@Injectable()
class Repository{
  Repository(this.webService);
  final WebService webService;

  Future<List<UserModel>> getListUser() async {
    try {
      dynamic response = await webService.getUser();
      return response;
    } catch (e) {
      throw e;
    }
  }
}