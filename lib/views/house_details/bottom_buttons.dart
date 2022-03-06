import 'package:flutter/material.dart';

import '../advertisingDetails/components/constants.dart';
import 'contactBox.dart';

class BottomButtons extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              boxShadow: [BoxShadow(
                color: darkBlue.withOpacity(0.6),
                offset: Offset(0,10),
                blurRadius: 10
              )]
            ),
            child: GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: _textEditingController,
                                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Name",
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _textEditingController,
                                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Email",
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _textEditingController,
                                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Message",
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Choice Box"),
                                    // Checkbox(
                                    //     value: isChecked,
                                    //     onChanged: (checked) {
                                    //       setState(() {
                                    //         isChecked = checked;
                                    //       });
                                    //     })
                                  ],
                                )
                              ],
                            )),
                        title: Text('Stateful Dialog'),
                        actions: <Widget>[
                          InkWell(
                            child: Text('OK   '),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // Do something like updating SharedPreferences or User Settings etc.
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      );
                    });


              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon((Icons.mail_rounded),color: white,),
                  Text(' Message',style: TextStyle(
                    color: white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),)
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
                boxShadow: [BoxShadow(
                    color: darkBlue.withOpacity(0.6),
                    offset: Offset(0,10),
                    blurRadius: 10
                )]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon((Icons.call_rounded),color: white,),
                Text(' Call',style: TextStyle(
                  color: white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
          ),
        ],
      ),

    );

  }


}
