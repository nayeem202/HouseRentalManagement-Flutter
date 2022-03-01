
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatelessWidget {

  Items item1 = new Items(
      title: "Apartment",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/image/apartment.png");

  Items item2 = new Items(
    title: "Duplex",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img: "assets/image/duplex.png",
  );
  Items item3 = new Items(
    title: "Single Family Detached House",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "assets/image/singlefamily.png",
  );
  Items item4 = new Items(
    title: "Villa",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "assets/image/villa.jpg",
  );
  Items item5 = new Items(
    title: "Tiny Home",
    subtitle: "Homework, Design",
    event: "4 Items",
    img: "assets/image/tiny.jpg",
  );
  Items item6 = new Items(
    title: "Commercial Space",
    subtitle: "",
    event: "2 Items",
    img: "assets/image/commercial.jpg",
  );

  


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Expanded(child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(10),
                boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
          ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  data.img,
                  width: 42,
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.title,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  data.subtitle,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.event,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }).toList()),
        )
      ],

    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({required this.title, required this.subtitle, required this.event, required this.img});
}
