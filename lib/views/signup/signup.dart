
import 'dart:developer';

import 'package:client_mobile/helper/constant.dart';
import 'package:client_mobile/helper/http_helper.dart';
import 'package:client_mobile/views/login/login.dart';
import 'package:client_mobile/views/signup/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();

  save() async{
    String name = _name.value.text;
    String username = _username.value.text;
    String email = _email.value.text;
    String phone = _phone.value.text;
    String password = _password.value.text;
    var model = SignupModel(name: name, username: username, email: email, phone: phone, password: password);
    String _body = model.toJson();
    try{
      final response = await _http.postData(registerApi, _body);
      if (response.statusCode == 200){
        Fluttertoast.showToast(
            msg: "Registration Successful",
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
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
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




  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
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
                height: height*0.45,
                child: Image.asset('assets/image/signup.png',fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Signup',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  hintText: 'Username',
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: _phone,
                decoration: InputDecoration(
                  hintText: 'Phone',
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
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



              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text('Signup'),
                      color: Color(0xffEE7B23),
                      onPressed: (){
                        save();
                      },
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(30.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text.rich(
                    TextSpan(
                        text: 'Already member ?',
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: Color(0xffEE7B23)
                            ),
                          ),
                        ]
                    ),
                  ),
                ),

              ),



            ],
          ),
        ),
      ),
    );
  }
}