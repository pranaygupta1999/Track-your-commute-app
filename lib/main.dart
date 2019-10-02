

import 'package:flutter/material.dart';
import './login.dart';


void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget startpage;
  @override
  void initState(){
    super.initState();

    startpage = LoginScreen(this);
  }
  void changeScreen(Widget screen) async {
    setState(() {
      startpage = screen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: startpage,),
      title: "Track Your Commute",
    );
  }
}

