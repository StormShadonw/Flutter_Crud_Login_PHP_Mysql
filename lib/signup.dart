import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config.dart';

class SignUp extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Container(
          width: 280,
          height: 260,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.purple,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      width: 280,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Username"),
                      maxLength: 25,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 22, color: Colors.purple),
                      ),
                      width: 280,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                      obscureText: true,
                      maxLength: 25,
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    child: RaisedButton(
                      onPressed: () {
                        if (usernameController.text.length > 0 ||
                            passwordController.text.length > 0) {
                          userCreate();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Sign up"),
                      color: Colors.purple,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                width: 280,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void userCreate() {
    var url = backend + "userCreate.php";
    http.post(url, body: {
      "username": usernameController.text,
      "password": passwordController.text,
    });
  }
}
