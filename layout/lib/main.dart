import 'package:flutter/material.dart';
import 'package:flutter_application_layout/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const ({ Key? key }) : super(key: ke//y);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Computer Knowledge",
      home: HomePage(),
    );
  }
}
