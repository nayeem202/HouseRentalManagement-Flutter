import 'dart:convert';
import 'package:client_mobile/helper/constant.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/http_helper.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';


class newAdvertisingForm extends StatefulWidget {
  @override
  newAdvertisingFormState createState() {
    return newAdvertisingFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class newAdvertisingFormState extends State<newAdvertisingForm> {
  Dio dio = new Dio();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  late String type;
  late String location;
  late String status;
  late File image;
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
    getImageFile();

    // image == null
    //     ? NetworkImage(
    //     'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
    //     : FileImage(image);

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


  Uri apiUrl = Uri.parse(
      SaveAdvertising);

  Future<Map<String, dynamic>?> _uploadImage(File image) async {
    setState(() {
      //pr.show();
    });

    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath(
        'file', image.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['location'] = location;
    imageUploadRequest.fields['type'] = type;
    imageUploadRequest.fields['status'] = status;
    imageUploadRequest.fields['bathrooms'] = _bathrooms.value.text;
    imageUploadRequest.fields['bedrooms'] = _bedrooms.value.text;
    imageUploadRequest.fields['sqft'] = _sqft.value.text;
    imageUploadRequest.fields['price'] = _rentprice.value.text;
    imageUploadRequest.fields['lat'] = double.parse(_lat.value.text) as String;
    imageUploadRequest.fields['lng'] = double.parse(_lng.value.text) as String;
    imageUploadRequest.fields['additionalInformation'] = _additionalInformation.value.text;
    imageUploadRequest.fields['user_id'] = userId;




    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //_resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _startUploading() async {
    if (image != null ||
        location != '' ||
        type != '' ||
        _bedrooms != '' ||
        _bathrooms != '' ||
        status != '') {
      final Map<String, dynamic>? response = await _uploadImage(image);

      // Check if any error occured
      if (response == null) {
        // pr.hide();
        //messageAllert('User details updated successfully', 'Success');
      }
    } else {
      //messageAllert('Please Select a profile photo', 'Profile Photo');
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
      appBar: AppBar(title: Text("Create New Advertise")),
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
                              _startUploading(),
                              //saveAd(),
                              print(image)

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
