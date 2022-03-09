import 'dart:convert';

import 'package:client_mobile/ep882_house_rental_app/ui/house_rental_home_page.dart';
import 'package:client_mobile/main.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../../helper/constant.dart';
import '../../helper/http_helper.dart';
import '../model/AdvertiseModel.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  @override
  BottomSheetWidgetState createState() => BottomSheetWidgetState();
}

class BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _http = new HttpHelper();

  var advertise = [];
  bool check = false;
  bool success = false;

  late String location;
  late String type;
  late String status;
  late String bedrooms;
  late String bathrooms;
  late String minprice;
  late String maxprice;
  late String minsqft;
  late String maxsqft;

  late String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    location = '';
    type = '';
    status = '';
    bedrooms = '';
    bathrooms = '';
    minprice = '';
    maxprice = '';
    minsqft = '';
    maxsqft = '';
    _myActivityResult = '';
  }



  // _saveForm() {
  //   var form = formKey.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     setState(() {
  //       _myActivityResult = _myActivity;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {

     return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 5)
                    ]),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 16, top: 25),
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
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 16, top: 25),
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
                                              "value":
                                                  "Single Family Detached House",
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
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(16),
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
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: DropDownFormField(
                                          hintText: 'Bedrooms',
                                          value: bedrooms,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(bedrooms);
                                              bedrooms = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "0",
                                              "value": "0",
                                            },
                                            {
                                              "display": "1",
                                              "value": "1",
                                            },
                                            {
                                              "display": "2",
                                              "value": "2",
                                            },
                                            {
                                              "display": "3",
                                              "value": "3",
                                            },
                                            {
                                              "display": "4",
                                              "value": "4",
                                            },
                                            {
                                              "display": "5",
                                              "value": "5",
                                            },
                                            {
                                              "display": "6",
                                              "value": "6",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: DropDownFormField(
                                          hintText: 'BathRooms',
                                          value: bathrooms,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(bathrooms);
                                              bathrooms = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "0",
                                              "value": "0",
                                            },
                                            {
                                              "display": "1",
                                              "value": "1",
                                            },
                                            {
                                              "display": "2",
                                              "value": "2",
                                            },
                                            {
                                              "display": "3",
                                              "value": "3",
                                            },
                                            {
                                              "display": "4",
                                              "value": "4",
                                            },
                                            {
                                              "display": "5",
                                              "value": "5",
                                            },
                                            {
                                              "display": "6",
                                              "value": "6",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: DropDownFormField(
                                          hintText: 'Min Sqft',
                                          value: minsqft,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(minsqft);
                                              minsqft = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "0",
                                              "value": "0",
                                            },
                                            {
                                              "display": "800",
                                              "value": "800",
                                            },
                                            {
                                              "display": "1600",
                                              "value": "1600",
                                            },
                                            {
                                              "display": "2400",
                                              "value": "2400",
                                            },
                                            {
                                              "display": "3600",
                                              "value": "3600",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: DropDownFormField(
                                          hintText: 'Max Sqft',
                                          value: maxsqft,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(maxsqft);
                                              maxsqft = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "800",
                                              "value": "800",
                                            },
                                            {
                                              "display": "3600",
                                              "value": "3600",
                                            },
                                            {
                                              "display": "4200",
                                              "value": "4200",
                                            },
                                            {
                                              "display": "8600",
                                              "value": "8600",
                                            },
                                            {
                                              "display": "10000",
                                              "value": "10000",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 16, bottom: 30),
                                        child: DropDownFormField(
                                          hintText: 'Min Price',
                                          value: minprice,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(minprice);
                                              minprice = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "5000",
                                              "value": "5000",
                                            },
                                            {
                                              "display": "10000",
                                              "value": "10000",
                                            },
                                            {
                                              "display": "20000",
                                              "value": "20000",
                                            },
                                            {
                                              "display": "40000",
                                              "value": "40000",
                                            },
                                            {
                                              "display": "80000",
                                              "value": "80000",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 16, bottom: 30),
                                        child: DropDownFormField(
                                          hintText: 'Max Price',
                                          value: maxprice,
                                          // onSaved: (value) {
                                          //   setState(() {
                                          //     _myActivity = value;
                                          //     print(_myActivity);
                                          //   });
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              print(maxprice);
                                              maxprice = value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "10000",
                                              "value": "10000",
                                            },
                                            {
                                              "display": "20000",
                                              "value": "20000",
                                            },
                                            {
                                              "display": "30000",
                                              "value": "30000",
                                            },
                                            {
                                              "display": "60000",
                                              "value": "60000",
                                            },
                                            {
                                              "display": "100000",
                                              "value": "100000",
                                            },
                                            {
                                              "display": "200000",
                                              "value": "200000",
                                            },
                                            {
                                              "display": "400000",
                                              "value": "400000",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),

                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: Text(_myActivityResult),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            !check
                                ? MaterialButton(
                                    color: Colors.grey[800],
                                    onPressed: () async {
                                      setState(() {
                                        check = true;
                                      });

                                      await Future.delayed(
                                          Duration(seconds: 1));

                                      setState(() {
                                        success = true;
                                      });

                                      await Future.delayed(
                                          Duration(milliseconds: 500));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HouseRentalHomePage(
                                                    value: '',
                                                    location: location,
                                                    type: type,
                                                    status: status,
                                                    bedrooms: bedrooms,
                                                    bathrooms: bathrooms,
                                                    minprice: minprice,
                                                    maxprice: maxprice,
                                                    minsqft: minsqft,
                                                    maxsqft: maxsqft,
                                                  )));
                                      //Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Searach',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : !success
                                    ? CircularProgressIndicator()
                                    : Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                          ],
                        ),
                      ),
                    ),
                    //SheetButton()
                  ],
                ),
              )
            ],
          ),
        ),
      );

  }
}

// class DecoratedTextField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration:
//             InputDecoration.collapsed(hintText: 'Enter your reference number'),
//       ),
//     );
//   }
// }
//
// class SheetButton extends StatefulWidget {
//   SheetButton({Key? key}) : super(key: key);
//
//
//   _SheetButtonState createState() => _SheetButtonState();
// }
//
// class _SheetButtonState extends State<SheetButton> {
//   bool check = false;
//   bool success = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return !check
//         ? MaterialButton(
//             color: Colors.grey[800],
//             onPressed: () async {
//
//               setState(() {
//                 check = true;
//               });
//
//               await Future.delayed(Duration(seconds: 1));
//
//               setState(() {
//                 success = true;
//
//               });
//
//               await Future.delayed(Duration(milliseconds: 500));
//
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyApp()),
//               );
//             },
//             child: Text(
//               'Searach',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           )
//         : !success
//             ? CircularProgressIndicator()
//             : Icon(
//                 Icons.check,
//                 color: Colors.green,
//               );
//   }
// }
