import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';


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
    final userVM = Provider.of<UserViewModel>(context);
    return ListView.builder(
        itemCount: userVM.getListUser().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(
                    userVM.getListUser()[index].avatar,
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(userVM.getListUser()[index].firstname),
                subtitle: Text(userVM.getListUser()[index].email),
              ));
        });
  }
}