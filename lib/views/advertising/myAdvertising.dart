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
  String userId = "0";

  getAdvertisingByuser() async {
    final res = await _http.getData(getAdvertisingByUser + "/" + userId);
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
      print(userId);
      getAdvertisingByuser();
    });
  }

  @override
  void initState() {
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
      title: Text("My Advertisement"),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                  itemCount: myadvertise.length,
                  itemBuilder: (context, index) {
                    AdvertiseModel model = this.myadvertise[index];
                    return Padding(padding: EdgeInsets.only(
                      top: 20, left: 8, right: 8
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height /
                                    4,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              14),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  model.imagesUri),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              decoration:
                                              BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              padding:
                                              const EdgeInsets
                                                  .all(8),
                                              child: Row(
                                                children: [
                                                  // const Icon(
                                                  //     Icons.star,
                                                  //     color: Colors
                                                  //         .blue),
                                                  const SizedBox(
                                                      width: 8),
                                                  Text(model.type)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration:
                                              BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              padding:
                                              const EdgeInsets
                                                  .all(8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .favorite,
                                                      color: Colors
                                                          .blue[
                                                      500]),
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "House No- " +
                                        model.advertisingId
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    model.price.toString() + " ৳",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 21),
                                  ),
                                  Text("/Month"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    model.location,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.bed_outlined,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    model.bedrooms.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.crop_square,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    model.sqft.toString() + " sqft",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    );
                  })
            ],
          ),
        )



      ),


    );
  }
}
