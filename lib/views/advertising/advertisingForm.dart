import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  late File image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    type = "";
    location = "";
    status = "";



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
                                  Text("Click on Pick Image to select an Image", style: TextStyle(fontSize: 18.0),),
                                RaisedButton(
                                  onPressed: () {
                                    getImageFile();
                                    // or
                                    // _pickImageFromCamera();
                                    // use the variables accordingly
                                  },
                                  child: Text("Pick Image From Gallery"),
                                ),
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
                            onPressed: null,
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
