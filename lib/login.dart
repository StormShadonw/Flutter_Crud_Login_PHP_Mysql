import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import './config.dart';
import './fetchNotes.dart';
import './signup.dart';


class LoginPageState extends State {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void loginUser() async {
    var url = backend + "fetchUsersLogin.php";
    final response = await http.post(url, body: {
      "username": usernameController.text,
      "password": passwordController.text
    });
    if (response.body == "CORRECTO") {
      Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) {
          return FetchNotes();
        }),
      );
    }
    else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Usuario o Clave Incorrecto",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.deepPurple,
          );
        });
    }

    usernameController.text = "";
    passwordController.text = "";
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Login"),
        ),
        body: Center(
          child: Container(
            height: 400,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(2),
                  width: 200,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Text(
                          "User",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Username"),
                        maxLength: 25,
                        controller: usernameController,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  width: 200,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Text(
                          "Password",
                          style: TextStyle(fontSize: 22, color: Colors.purple),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Password"),
                        maxLength: 25,
                        obscureText: true,
                        controller: passwordController,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Center(
                    child: Container(
                      width: 200,
                      child: RaisedButton(
                        color: Colors.purple,
                        textColor: Colors.white,
                        child: Text("Sign in"),
                        onPressed: loginUser,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Center(
                    child: Container(
                      width: 200,
                      child: RaisedButton(
                        color: Colors.purple,
                        textColor: Colors.white,
                        child: Text("Sign up"),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new SignUp(),
                          ));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}
