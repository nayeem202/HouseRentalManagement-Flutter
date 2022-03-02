
import 'package:client_mobile/ep882_house_rental_app/ui/house_rental_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../signup/signup.dart';

class CategoryPage extends StatelessWidget {
  late final List<String> value = ["Apartment", "Duplex", "Single Family Detached House", "Villa", "Tiny home", "Commercial Space"];
  //late String value;

  Items item1 = new Items(
      title: "Apartment",
      subtitle: "Apartment",
      img: "assets/image/apartment.png");

  Items item2 = new Items(
    title: "Duplex",
    subtitle: "Duplex",
    img: "assets/image/duplex.png",
  );
  Items item3 = new Items(
    title: "Single Family Detached House",
    subtitle: "Single Family Detached House",
    img: "assets/image/singlefamily.png",
  );
  Items item4 = new Items(
    title: "Villa",
    subtitle: "Villa",
    img: "assets/image/villa.jpg",

  );
  Items item5 = new Items(
    title: "Tiny Home",
    subtitle: "Tiny Home",
    img: "assets/image/tiny.jpg",
  );
  Items item6 = new Items(
    title: "Commercial Space",
    subtitle: "",
    img: "assets/image/commercial.jpg",
  );

  


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    //var color = 0xff453658;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
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
                 borderRadius: BorderRadius.circular(10),
                color: Colors.white,
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

                TextButton(
                  onPressed: (){
                    if(data.title== "Apartment"){
                      print("Hello");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[0],)
                      ));
                    }
                    if(data.title== "Duplex"){
                      print("Hello");
                      print(value[0]);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[1],)));
                    }
                    if(data.title== "Single Family Detached House"){
                      print("Hello");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[2])));
                    }
                    if(data.title== "Villa"){
                      print("Hello");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[3])));
                    }
                    if(data.title == "Tiny Home"){
                      print("Hello");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[4])));
                    }
                    if(data.title== "Commercial Space"){
                      print("Hello");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseRentalHomePage(value: value[5])));
                    }
                  },
                  child: Text(
                      "Click me"
                  ),
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
  String img;
  Items({required this.title, required this.subtitle,required this.img});
}
