import 'package:flutter_mvvm_architecture_a_z/data/model/user_model.dart';
import 'package:flutter_mvvm_architecture_a_z/data/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc{
  UserBloc({required this.repository});

  final Repository repository;
  final _userFetcher = BehaviorSubject<List<UserModel>>();


  BehaviorSubject<List<UserModel>> get userFetcher => _userFetcher;

  void fetchUser() async{
    final List<UserModel> modelApi = await repository.getListUser();
    _userFetcher.sink.add(modelApi);
  }
  void dispose(){
    _userFetcher.close();
  }
}
