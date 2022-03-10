import 'dart:convert';

import 'package:client_mobile/views/login/login_model.dart';
import 'package:flutter/material.dart';
import '../../ep882_house_rental_app/model/AdvertiseModel.dart';
import '../../helper/constant.dart';
import '../../helper/http_helper.dart';
import '../advertising/advertisingForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  @override  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String name = "";
  final _http = new HttpHelper();
  late Future<LoginModel> userInfo;


  @override
  void initState() {
    getLocalData();
    getUserInfo();
  }


  getUserInfo() async {

    final res = await _http.getData("http://192.168.0.104:9092/getUserInfo/" + "khalil");
    if (res.statusCode == 200) {
      Map<dynamic, dynamic> data = jsonDecode(res.body);
      print(data);
      setState(() {
        this.userInfo;
      });
    }
  }


  getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      print(name);

    });
  }



  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nav Drawer"), backgroundColor: Colors.deepPurpleAccent,),
      body: Column(
        children: [
           Center(
             child: Padding(
               padding: EdgeInsets.all(16.0),
               child: Text(" Welcome Mr " + name , textAlign: TextAlign.center,
                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87,fontSize: 20.0),),
             ),
           )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Nayeem Ahmed"),
              accountEmail: new Text("nayeem.ahmedemba@gmail.com"),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage('https://www.expatica.com/app/uploads/sites/9/2017/06/Lake-Oeschinen-1200x675.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/image/pp.jpg")),
            ),
            new ListTile(
                leading: Icon(Icons.account_circle_rounded),
                title: new Text("Profile"),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdvertisingForm()),
                  );

                  //Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.post_add),
                title: new Text("Advertise Now"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.my_library_books_outlined),
                title: new Text("My Post"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new Divider(),
            new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}