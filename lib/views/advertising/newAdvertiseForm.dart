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
import 'package:video_player/video_player.dart';
import '../../helper/http_helper.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';


class newAdvertisingForm extends StatefulWidget {
  @override
  newAdvertisingFormState createState() {
    return newAdvertisingFormState();
  }
}

class newAdvertisingFormState extends State<newAdvertisingForm> {
  Dio dio = new Dio();
  final _formKey = GlobalKey<FormState>();
  late VideoPlayerController _videoPlayerController;

  late String type;
  late String location;
  late String status;
  var image;
  var image1;
  var image2;
  var video;

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
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final videoPick  = ImagePicker();


  @override
  void initState() {
    super.initState();
    //getImageFile();


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
      SaveAdvertisingWithFile);

  Future<Map<String, dynamic>?> _uploadImage(File image, File image1, File image2) async {
    setState(() {
      //pr.show();
    });

    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final mimeTypeData1 =
    lookupMimeType(image1.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final mimeTypeData2 =
    lookupMimeType(image2.path, headerBytes: [0xFF, 0xD8])?.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath(
        'files', image.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

    final file1 = await http.MultipartFile.fromPath(
        'files', image1.path,
        contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]));

     final file2 = await http.MultipartFile.fromPath(
         'files', image2.path,
        contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]));


    final fileVideo = await http.MultipartFile.fromPath(
        'file', video.path,
        contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));


    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(file1);
    imageUploadRequest.files.add(file2);
    imageUploadRequest.files.add(fileVideo);

    imageUploadRequest.fields['location'] = location;
    imageUploadRequest.fields['type'] = type;
    imageUploadRequest.fields['status'] = status;
    imageUploadRequest.fields['bathrooms'] = _bathrooms.value.text;
    imageUploadRequest.fields['bedrooms'] = _bedrooms.value.text;
    imageUploadRequest.fields['sqft'] = _sqft.value.text;
    imageUploadRequest.fields['price'] = _rentprice.value.text;
    imageUploadRequest.fields['lat'] = _lat.value.text;
    imageUploadRequest.fields['lng'] = _lng.value.text;
    imageUploadRequest.fields['additionalinformation'] = _additionalInformation.value.text;
    imageUploadRequest.fields['user_id'] = userId;




    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        print(_additionalInformation.value.text);
        final snackBar = SnackBar(
            content: const Text('Advertise Successfully Published'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ));
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final snackBar = SnackBar(
          content: const Text('Advertise failed to publish'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ));


      return responseData;
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: const Text('Yay'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ));

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
      final Map<String, dynamic>? response = await _uploadImage(image, image1, image2);

      // Check if any error occured
      if (response == null) {
        // pr.hide();
        //messageAllert('User details updated successfully', 'Success');

      }
    } else {
      //messageAllert('Please Select a profile photo', 'Profile Photo');
      final snackBar = SnackBar(
          content: const Text('Yay! A SnackBar!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ));

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

  Future getImageFile1() async {
    final pickedFile1 = await picker1.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile1 != null) {
        image1 = File(pickedFile1.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFile2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile2 != null) {
        image2 = File(pickedFile2.path);
      } else {
        print('No image selected.');
      }
    });
  }


  Future getVideoFile() async {
    final pickedVideo = await videoPick.getVideo(source: ImageSource.gallery);

      if (pickedVideo != null) {
        video = File(pickedVideo.path);
        _videoPlayerController = VideoPlayerController.file(video)..initialize().then((_) {
          setState(() { });
          _videoPlayerController.play();
        });
      } else {
        print('No image selected.');
      }




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
                            width: MediaQuery.of(context).size.width / 1.2,
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
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25),
                                  child: TextFormField(
                                    //keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    controller: _additionalInformation,
                                    decoration: const InputDecoration(
                                      //icon: const Icon(Icons.phone),
                                      hintText: 'Additional Information',
                                      //labelText: 'Longitude',
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
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(image != null)
                                  Image.file(image)
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 16),
                                    child: Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color:Colors.green
                                    ),
                                  ),
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25, bottom: 8),
                                  child: RaisedButton(
                                    onPressed: () {
                                      getImageFile();


                                    },
                                    child: Text("Choose Image"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(image1 != null)
                                  Image.file(image1)
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 16),
                                    child: Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color:Colors.green
                                    ),
                                  ),
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25, bottom: 8),
                                  child: RaisedButton(
                                    onPressed: () {
                                      getImageFile1();
                                    },
                                    child: Text("Choose Image"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(image2 != null)
                                  Image.file(image2)
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 16),
                                    child: Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color:Colors.green
                                    ),
                                  ),
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 25, bottom: 8),
                                  child: RaisedButton(
                                    onPressed: () {
                                      getImageFile2();
                                    },
                                    child: Text("Choose Image"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Column(



                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (video != null)
                                  _videoPlayerController.value.isInitialized
                                      ? AspectRatio(
                                    aspectRatio: _videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(_videoPlayerController),
                                  )
                                      : Container()
                                  else
                                  Padding(

                                    padding: const EdgeInsets.only( top: 16,),
                                    child: Icon(
                                        Icons.video_collection,
                                        size: 50,
                                        color:Colors.green
                                    ),
                                  ),
                                Container(

                                  padding: EdgeInsets.only( top: 25, bottom: 8),
                                  child: RaisedButton(
                                    onPressed: () {
                                      getVideoFile();
                                    },
                                    child: Text("Choose Video"),
                                  ),
                                )
                              ],
                            ),
                          ),


                        ],
                      ),


                      new Container(
                        alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 50.0, top: 6.0, bottom: 20, right: 50),
                          child: SizedBox(
                            width: 200,
                            child: new RaisedButton(
                              hoverColor: Colors.deepPurple,

                              child: const Text('Publish'),
                              onPressed: () => {
                                _startUploading(),
                                //saveAd(),
                                print(image),
                                print(image1),
                                print(image2),

                                print(_lat.value.text)
                              },
                            ),
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
