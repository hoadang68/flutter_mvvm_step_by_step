import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> list = [];
  @override
  void initState() {
    super.initState();
    getData();
  }
  void getData() async {
    try {
      var response = await Dio()
          .get('https://reqres.in/api/users?page=1');
      if (response.statusCode == 200) {
        setState(() {
          final List result = response.data['data'] as List;
          list = result.map(((e) => UserModel.fromJson(e))).toList();
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(
                    list[index].avatar,
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(list[index].firstname),
                subtitle: Text(list[index].email),
              ));
        });
  }
}
class UserModel {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;
  UserModel(
      {required this.id,
        required this.email,
        required this.firstname,
        required this.lastname,
        required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        firstname: json['first_name'] ?? 'First Name',
        lastname: json['last_name'] ?? 'Last Name',
        avatar: json['avatar'] ??
            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg');
  }
}