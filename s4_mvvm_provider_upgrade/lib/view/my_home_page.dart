import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_architecture_a_z/api/api_response.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<UserViewModel>(context).apiResponse;
    List<UserModel>? userVM = apiResponse.data as List<UserModel>?;
    if (apiResponse.status == Status.loading || apiResponse.status == Status.initial){
      return const Center(child: CircularProgressIndicator(),);
    } else {
      return ListView.builder(
          itemCount: userVM?.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(
                      userVM?[index].avatar ?? "",
                      fit: BoxFit.fill,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: Text(userVM?[index].firstname ?? ""),
                  subtitle: Text(userVM?[index].email ?? ""),
                ));
          });
    }

  }
}