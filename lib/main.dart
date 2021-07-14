import 'package:flutter/material.dart';
import 'package:http_req_advanced/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTTP Req',
      home: MyHomePage(),
    );
  }
}
