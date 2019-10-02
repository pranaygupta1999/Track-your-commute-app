import 'dart:convert';
import 'config.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'main.dart';
import 'map.dart' as MapScreen;

class LoginScreen extends StatefulWidget {
  final MyAppState myAppState;
  LoginScreen(this.myAppState);

  @override
  _LoginScreenState createState() => _LoginScreenState(myAppState);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState(this.myAppState);

  MyAppState myAppState;
  BuildContext buildContext;
  TextField usernameField;
  TextField passwordField;
  Widget loginButton;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  String username, password;

  
  void initState() {
    super.initState();
  }

  void showSnackbar(BuildContext context, String msg, {TextStyle textStyle}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: textStyle,
      ),
      duration: Duration(seconds: 1),
    ));
  }

  void handleLogin() async {
    username = usernameController.text;
    password = passwordController.text;
    var loginResponse;
    try {
      loginResponse = await Http.post(Config.SERVER_IP+"/login",
              body: {"username": username, "password": password});
      if (loginResponse.statusCode == 200) {
        showSnackbar(context, "Welcome " + username);
        MapScreen.Map map = MapScreen.Map();
        myAppState.changeScreen(map);
        
      } else {
        showSnackbar(context, json.decode(loginResponse.body)['msg']);
        print("some error");
      }
    } on Error catch (e) {
      showSnackbar(context, "Error in connecting to server",
          textStyle: TextStyle(color: Colors.redAccent));
      print("error");
    } on Exception catch (e) {
      showSnackbar(context, "Error in connecting to server",
          textStyle: TextStyle(color: Colors.redAccent));
      print("exception");
    }
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    usernameField = TextField(
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.emailAddress,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: "Username",
        contentPadding: EdgeInsets.fromLTRB(22, 18, 22, 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    passwordField = TextField(
      style: TextStyle(fontSize: 20),
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: EdgeInsets.fromLTRB(22, 18, 22, 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    loginButton = MaterialButton(
      elevation: 8.0,
      padding: EdgeInsets.all(18),
      height: 50,
      color: Colors.green,
      splashColor: Colors.greenAccent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
      minWidth: MediaQuery.of(context).size.width,
      child: Text("Track Your Commute",
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: handleLogin,
    );

    return Container(
      padding: EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(height: 46),
          usernameField,
          SizedBox(
            height: 15,
          ),
          passwordField,
          SizedBox(
            height: 35,
          ),
          loginButton
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
