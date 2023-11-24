import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture_a_z/data/repository/repository.dart';
import 'package:flutter_mvvm_architecture_a_z/data/service/web_service.dart';
import '../bloc/user_bloc.dart';
import '../data/model/user_model.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(repository: Repository(WebService(Dio())));
    _userBloc.fetchUser();
  }
  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userBloc.userFetcher,
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasData) {
            return listUser(
                (snapshot.data as List<UserModel>));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget listUser(List<UserModel> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(
                    users[index].avatar,
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(users[index].firstname),
                subtitle: Text(users[index].email),
              ));
        });
  }
}
