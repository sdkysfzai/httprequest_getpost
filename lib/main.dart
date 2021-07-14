import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_req_advanced/usermodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Request 2',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var users;
  Future<UserModel> createUser(String name, String job) async {
    final apiUrl = "https://reqres.in/api/users";
    final response =
        await http.post(Uri.parse(apiUrl), body: {"name": name, "job": job});

    if (response.statusCode == 201) {
      users = userModelFromJson(response.body);
    } else
      throw Exception('Failed to load');
    return users;
  }

  UserModel? user;

  final nameController = TextEditingController();
  final jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: jobController,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = nameController.text;
                  final String job = jobController.text;

                  final UserModel userr = await createUser(name, job);

                  setState(() {
                    user = userr;
                  });
                },
                child: Text('Make a Request'),
              ),
              user != null
                  ? _showData(user!.name, user!.job, user!.id, user!.createdAt)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showData(String name, String job, String id, DateTime createdat) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 32,
        child:
            Text('The user $name [$id] is created at $createdat with job $job'),
      ),
    );
  }
}
