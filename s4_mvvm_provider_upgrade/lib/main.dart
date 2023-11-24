import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'view/my_home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
