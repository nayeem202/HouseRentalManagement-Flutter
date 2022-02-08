import 'dart:developer';

import 'package:client_mobile/helper/http_helper.dart';
import 'package:client_mobile/views/signup/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  save() async{
    String name = _name.value.toString() ?? '';
    String username = _username.value.toString() ?? '';
    String email = _email.value.toString() ?? '';
    String phone = _phone.value.toString() ?? '';
    String password = _password.value.toString() ?? '';
    var model = SignupModel(name: name, username: username, email: email, phone: phone, password: password);
    String _body = model.toJson();
    try{
      final response = await _http.postData('http://192.168.0.104:9092/saveUser', _body);

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form'),),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Member Registration Form", style: TextStyle(fontSize: 16),),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
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
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextFormField(
                controller: _phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
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
                  this.save();
                  print(this._name);
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      )
    );
  }
}
