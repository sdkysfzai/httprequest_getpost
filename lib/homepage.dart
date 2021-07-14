import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_req_advanced/usermodel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<UserModel> createUser(String name, String job) async {
    var users;
    final response = await http.post(Uri.parse('https://reqres.in/api/users'),
        body: {"name": name, "job": job});
    if (response.statusCode == 201) {
      users = userModelFromJson(response.body);
    } else
      throw Exception('Failed to Load');
    return users;
  }

  final nameController = TextEditingController();
  final jobController = TextEditingController();
  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Post'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter name'),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Job'),
              controller: jobController,
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  final UserModel user =
                      await createUser(nameController.text, jobController.text);
                  setState(
                    () {
                      _user = user;
                    },
                  );
                },
                child: Text('Send Request')),
            _user == null
                ? Container()
                : _showData(
                    _user!.name, _user!.id, _user!.createdAt, _user!.job)
          ],
        ),
      ),
    );
  }

  Widget _showData(String name, String id, DateTime createdAt, String job) {
    return Container(
      child:
          Text('The user $name [$id] is created at $createdAt with Job $job'),
    );
  }
}
