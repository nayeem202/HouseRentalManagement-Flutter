import 'dart:developer';

import 'package:client_mobile/helper/http_helper.dart';
import 'package:client_mobile/views/login/login_model.dart';
import 'package:client_mobile/views/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();
  final _username = TextEditingController();
  final _password = TextEditingController();

  login() async{

    String username = _username.value.text;
    String password = _password.value.text;
    var loginModel = LoginModel(username: username, password: password);
    String _body = loginModel.toJson();
    try{
      final response = await _http.postData('http://192.168.0.104:9092/login', _body);
      if (response.statusCode == 200){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );

        Fluttertoast.showToast(
            msg: "Login SuccessFul",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
      else{
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }catch(e){
      log(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login Form'),),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Member Login ", style: TextStyle(fontSize: 16),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(7.0),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                 login();
                    print(_username);

                  },
                  child: Text('Login'),
                ),
              )
            ],
          ),
        )
    );
  }
}
