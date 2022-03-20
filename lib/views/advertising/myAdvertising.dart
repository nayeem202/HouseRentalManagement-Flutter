import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ep882_house_rental_app/model/AdvertiseModel.dart';
import '../../helper/constant.dart';
import '../../helper/http_helper.dart';

class MyAdvertising extends StatefulWidget {
  const MyAdvertising({Key? key}) : super(key: key);

  @override
  _MyAdvertisingState createState() => _MyAdvertisingState();
}

class _MyAdvertisingState extends State<MyAdvertising> {
  final _http = new HttpHelper();
  var myadvertise = [];
  late String userId;


  getAdvertisingByuser() async {
    final res = await _http.getData(getAdvertisingByUser + "/" + userId );
    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      myadvertise = data.map((e) => AdvertiseModel.fromMap(e)).toList();
      print(myadvertise);
      setState(() {
        this.myadvertise;
      });
    }
  }

  getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id')!;
    });
  }


  @override
  void initState(){
    getAdvertisingByuser();
    getLocalData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Advertisement"),

      )
    );
  }
}
