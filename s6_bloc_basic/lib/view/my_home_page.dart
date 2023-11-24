import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/model/user_model.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_bloc.dart';
import '../service/web_service.dart';
import '../viewmodel/user_event.dart';
import '../viewmodel/user_state.dart';

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
    _userBloc = UserBloc(webService: WebService());
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

