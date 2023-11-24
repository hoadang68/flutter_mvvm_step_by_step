import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/data/repository/repository.dart';
import 'package:flutter_mvvm_architecture_a_z/data/service/web_service.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
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
    _userBloc.add(FetchUser());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create) => _userBloc,// UserBloc(webService: WebService())..add(FetchUser()),
        child: Scaffold(
          body: BlocBuilder<UserBloc, UserState>(builder: (context, state){
            if (state is UserLoaded){
              List<UserModel> users = state.users;
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
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
        },
        )),
    );
  }
}

