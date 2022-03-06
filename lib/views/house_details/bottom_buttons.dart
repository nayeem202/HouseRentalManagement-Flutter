import 'package:flutter/material.dart';

import '../advertisingDetails/components/constants.dart';

class BottomButtons extends StatelessWidget {
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
