import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/model/user_model.dart';
import 'package:flutter_mvvm_architecture_a_z/service/web_service.dart';
import '../viewmodel/user_cubit.dart';
import '../viewmodel/user_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserCubit _userCubit;
  @override
  void initState() {
    super.initState();
    _userCubit = UserCubit(webService: WebService());
    // _userCubit.fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create) => _userCubit,
        child: Scaffold(
          body: BlocBuilder<UserCubit, UserState>(builder: (context, state){
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

