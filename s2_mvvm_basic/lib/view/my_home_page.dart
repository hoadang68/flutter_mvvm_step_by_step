import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserViewModel viewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.fetchUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var users = snapshot.data;
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
      },
    );
  }
}