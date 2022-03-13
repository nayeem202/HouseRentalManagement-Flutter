import 'dart:convert';
import 'dart:developer';
import 'package:client_mobile/helper/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http_helper.dart';

class AdvertisingForm extends StatefulWidget {
  @override
  AdvertisingFormState createState() {
    return AdvertisingFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class AdvertisingFormState extends State<AdvertisingForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  late String type;
  late String location;
  late String status;
  var image;
  final _http = HttpHelper();
  late String userId;


  final TextEditingController _bedrooms = TextEditingController();
  final TextEditingController _bathrooms = TextEditingController();
  final TextEditingController _sqft = TextEditingController();
  final TextEditingController _rentprice = TextEditingController();
  final TextEditingController _additionalInformation = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _lng = TextEditingController();




  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getLocalData();
    type = "";
    location = "";
    status = "";
  }

  final uri = SaveAdvertising;

  getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id')!;
    });
  }



  saveAd() async{
    // var fileContent = image.readAsBytesSync();
    // var fileContentBase64 = base64.encode(fileContent);

    var map = new Map<String, dynamic>();
    map['bedrooms'] = _bedrooms.value.text;
    map['bathrooms'] = _bathrooms.value.text;
    map['location'] = location;
    map['type'] = type;
    map['status'] = status;
    map['price'] = _rentprice.value.text;
    map['sqft'] = _sqft.value.text;
    map['file'] = image.toString();
    map['user_id'] = userId;




    print(map);
    //String _body = model.toJson();
    try{
      http.Response response = await http.post(
       Uri.parse(uri),
        body: map,
      );

      if (response.statusCode == 200){
        Fluttertoast.showToast(
            msg: "Advertise successFully published",
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





  Future getImageFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: Text("New Advertising")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10, color: Colors.grey, spreadRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 25),
                                  child: DropDownFormField(
                                    hintText: 'Select Type',
                                    value: type,
                                    // onSaved: (value) {
                                    //   setState(() {
                                    //     _myActivity = value;
                                    //     print(_myActivity);
                                    //   });
                                    // },
                                    onChanged: (value) {
                                      setState(() {
                                        print(type);
                                        type = value;
                                      });
                                    },
                                    dataSource: [
                                      {
                                        "display": "Apartment",
                                        "value": "Apartment",
                                      },
                                      {
                                        "display": "Duplex",
                                        "value": "Duplex",
                                      },
                                      {
                                        "display":
                                            "Single Family Detached House",
                                        "value": "Single Family Detached House",
                                      },
                                      {
                                        "display": "Villa",
                                        "value": "Villa",
                                      },
                                      {
                                        "display": "Tiny home",
                                        "value": "Tiny home",
                                      },
                                      {
                                        "display": "Commercial Space",
                                        "value": "Commercial Space",
                                      },
                                      {
                                        "display": "Office",
                                        "value": "Office",
                                      },
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: DropDownFormField(
                                    hintText: 'Select Location',
                                    value: location,
                                    // onSaved: (value) {
                                    //   setState(() {
                                    //     _myActivity = value;
                                    //     print(_myActivity);
                                    //   });
                                    // },
                                    onChanged: (value) {
                                      setState(() {
                                        print(location);
                                        location = value;
                                      });
                                    },
                                    dataSource: [
                                      {
                                        "display": "Dhanmondi",
                                        "value": "Dhanmondi",
                                      },
                                      {
                                        "display": "Gulshan",
                                        "value": "Gulshan",
                                      },
                                      {
                                        "display": "Banani",
                                        "value": "Banani",
                                      },
                                      {
                                        "display": "Mirpur",
                                        "value": "Mirpur",
                                      }
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 25),
                                  child: TextFormField(
                                    controller: _bedrooms,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Bedrooms',
                                      labelText: 'Bedrooms',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: TextFormField(
                                    controller: _bathrooms,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Bathrooms',
                                      labelText: 'Bathrooms',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 25),
                                  child: TextFormField(
                                    controller: _sqft,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Sqft',
                                      labelText: 'Sqft',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: TextFormField(
                                    controller: _rentprice,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Rent Price',
                                      labelText: 'Rent Price',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 25),
                                  child: DropDownFormField(
                                    hintText: 'Select Status',
                                    value: status,
                                    // onSaved: (value) {
                                    //   setState(() {
                                    //     _myActivity = value;
                                    //     print(_myActivity);
                                    //   });
                                    // },
                                    onChanged: (value) {
                                      setState(() {
                                        print(status);
                                        status = value;
                                      });
                                    },
                                    dataSource: [
                                      {
                                        "display": "Bachelor",
                                        "value": "Bachelor",
                                      },
                                      {
                                        "display": "Family(>=3 Members)",
                                        "value": "Family(>=3 Members)",
                                      },
                                      {
                                        "display": "Family(3+ Members)",
                                        "value": "Family(3+ Members)",
                                      },
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 25),
                                  child: TextFormField(
                                    controller: _lat,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Latitude',
                                      labelText: 'Latitude',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: TextFormField(
                                    controller: _lng,

                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Longitude',
                                      labelText: 'Longitude',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(image != null)
                                  Image.file(image)
                                else
                                  Text("select an Image",),
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: RaisedButton(
                                    onPressed: () {
                                      getImageFile();
                                    },
                                    child: Text("Pick Image From Gallery"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width:
                          //   MediaQuery.of(context).size.width / 2.3,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         padding:
                          //         EdgeInsets.only(left: 16, top: 25),
                          //         child:   TextFormField(
                          //           decoration: const InputDecoration(
                          //             //icon: const Icon(Icons.phone),
                          //             hintText: 'Longitude',
                          //             labelText: 'Longitude',
                          //           ),
                          //         ),
                          //       )
                          //
                          //     ],
                          //   ),
                          //
                          // )
                        ],
                      ),
                      new Container(
                          padding: const EdgeInsets.only(
                              left: 150.0, top: 40.0, bottom: 20),
                          child: new RaisedButton(
                            child: const Text('Submit'),
                            onPressed: () => {
                              saveAd(),
                              print( this._bedrooms.value.text)

                            },
                          )),
                    ],
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
