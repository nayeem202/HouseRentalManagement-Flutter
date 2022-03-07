import 'dart:convert';
import 'dart:developer';
import 'package:client_mobile/helper/constant.dart';
import 'package:http/http.dart' as http;
import 'package:client_mobile/views/house_details/houseInfo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../helper/http_helper.dart';
import '../advertisingDetails/components/constants.dart';
//import 'contactBox.dart';

class BottomButtons extends StatelessWidget {
  final  _textEditingControllername = TextEditingController();
  final  _textEditingControlleremail = TextEditingController();
  final  _textEditingControllermessage = TextEditingController();
  final _http = HttpHelper();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var name;
  var email;
  var phone;

  sendMail() async{
    String to = email;
    String subject = "Someone wants to connect with you for rent";
   //List<String> prices=[_textEditingControllername, _textEditingControlleremail, _textEditingControllermessage];



    try{
      var map = new Map<String, dynamic>();
      map["to"] = to;
      map["subject"] = subject;
      map["message"] = _textEditingControllermessage.text;

      final response = await _http.postData(sendMailUri,  jsonEncode(map));
      if (response.statusCode == 200){
        print(jsonEncode(map));
        Fluttertoast.showToast(
            msg: "Message Sent Successfully",
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
            msg: "Sent Message Failed",
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

  BottomButtons({required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(

      padding: const EdgeInsets.only(bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: darkBlue.withOpacity(0.6),
                      offset: Offset(0, 10),
                      blurRadius: 10)
                ]),
            child: GestureDetector(
              onTap: () {
                print(email);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //single child
                      return AlertDialog(
                        content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(

                                  padding: EdgeInsets.only(bottom: 5),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.person,
                                            size: 14,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ("  Owner Name- " + name),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.email,
                                            size: 14,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ("  Email- " + email),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _textEditingControllername,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Type Your Name",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _textEditingControlleremail,

                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Type Your Email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _textEditingControllermessage,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Type your Message",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                ),
                              ],
                            )),


                        title: Text(' Contact Form',
                          textAlign: TextAlign.center,  style: TextStyle(

                            decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double,
                              decorationThickness: 1,
                              decorationColor: Colors.green,


                          )),
                        actions: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20, right: 30),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.green,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Send',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                sendMail();
                                print(_textEditingControllermessage.text);
                                print(_textEditingControllername.text);
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    (Icons.mail_rounded),
                    color: white,
                  ),
                  Text(
                    ' Message',
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: darkBlue.withOpacity(0.6),
                      offset: Offset(0, 10),
                      blurRadius: 10)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  (Icons.call_rounded),
                  color: white,
                ),
                Text(
                  ' Call',
                  style: TextStyle(
                    color: white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
