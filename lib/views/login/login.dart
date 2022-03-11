import 'dart:convert';
import 'dart:developer';
import 'package:client_mobile/helper/http_helper.dart';
import 'package:client_mobile/views/signup/signup.dart';
import 'package:client_mobile/views/signup/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';
import '../NavigationDrawer/navDrawer.dart';
import '../profile/profile_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();
  final _username = TextEditingController();
  final _password = TextEditingController();
  var products = [];

  login() async {
    String username = _username.value.text;
    String password = _password.value.text;
    var signupmodel = SignupModel(
        username: username, password: password, email: '', name: '', phone: '');
    String body = signupmodel.toJson();

    try {
      final response = await _http.postData(loginApi, body);
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = (jsonDecode(response.body));
        SignupModel model = SignupModel.fromMap(data['data']);
        print(model);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', model.name);
        prefs.setString('username', model.username);
        prefs.setString('email', model.email);
        prefs.setString('phone', model.phone);
        prefs.setString('password', model.password);
        prefs.setString('id', model.id.toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );

        Fluttertoast.showToast(
            msg: "Login SuccessFul",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.45,
                child: Image.asset(
                  'assets/image/signin.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16, right: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Text('Login'),
                      color: Color(0xffEE7B23),
                      onPressed: () {
                        login();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account ? ', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
