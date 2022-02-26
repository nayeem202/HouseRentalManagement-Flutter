import 'dart:convert';
import 'package:client_mobile/ep882_house_rental_app/model/AdvertiseModel.dart';
import 'package:client_mobile/helper/http_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_notebook_14th_story/ep882_house_rental_app/model/house.dart';

class HouseRentalHomePage extends StatefulWidget {
  const HouseRentalHomePage({Key? key}) : super(key: key);

  @override
  _HouseRentalHomePageState createState() => _HouseRentalHomePageState();
}

class _HouseRentalHomePageState extends State<HouseRentalHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _http = new HttpHelper();
  var advertise = [];
  final _search = TextEditingController();



  static const snackBar = SnackBar(
    content: Text('Get Advertise SuccessFully '),
  );


  getAdvertisingBySearch() async {
    String search = _search.value.text;
    final res = await _http.getData("http://192.168.0.104:9092/getAddvertisingBySearch/"+search);
    if(res.statusCode == 200){
      List<dynamic> data = jsonDecode(res.body);
      advertise = data.map((e) => AdvertiseModel.fromMap(e)).toList();
      print(advertise);
      //this.advertise = data.map((e) => AdvertiseModel.fromMap(e));
      print(search);
      //showInSnackBar(data["message"]);
      setState(() {
        this.advertise;
      });
    }
  }

  getAdvertising() async {
    final res = await _http.getData("http://192.168.0.104:9092/getAddvertising");
    if(res.statusCode == 200){
      List<dynamic> data = jsonDecode(res.body);
     advertise = data.map((e) => AdvertiseModel.fromMap(e)).toList();
      print(advertise);
      //this.advertise = data.map((e) => AdvertiseModel.fromMap(e));
      print("Hello");
      //showInSnackBar(data["message"]);
      setState(() {
        this.advertise;
      });
    }
  }

  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
      super.initState(); //fetchAlbum();
      // pageController = PageController(initialPage: selectedIndex);
     _tabController = TabController(length: 3, vsync: this);
      if(_search == null || _search == ""){
        getAdvertising();
      }else{
        getAdvertising();
      }


      //getAdvertising();
      //getAdvertisingBySearch();
      pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     // appBar: AppBar(title: Text("House Rental Management"), centerTitle: true,),
      resizeToAvoidBottomInset: false,

      body: Container(

        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // SizedBox(
                        //   height: 24,
                        // ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],

                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                               Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  textInputAction: TextInputAction.search,
                                  controller: _search,
                                  decoration: InputDecoration(
                                      //hintText: "Search", icon: Icon(Icons.search),
                                      hintText: "Search",
                                      prefixIcon:  IconButton(icon: Icon(Icons.search),onPressed: () {
                                        getAdvertisingBySearch();
                                        setState(() {

                                        });},),

                                      suffixIcon:  IconButton(icon: Icon(Icons.clear),onPressed: () {
                                        setState(() {
                                          getAdvertising();
                                          _search.clear();
                                        });},) ,
                                      border: InputBorder.none),

                                ),
                              )),
                              const SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed("/search/filter"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                  child: const Center(
                                    child: Icon(
                                      Icons.filter_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 3,
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.transparent,
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Recommended"),
                    Tab(text: "Featured"),
                    Tab(text: "Popular"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: this.advertise.length,
                          //itemCount: houseItems.length,
                          itemBuilder: (context, index) {
                            AdvertiseModel model =  this.advertise[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height / 3,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    image: DecorationImage(
                                                        image: NetworkImage(model.imagesUri),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: 16,
                                                  right: 16,
                                                  top: 16,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        padding: const EdgeInsets.all(8),
                                                        child: Row(
                                                          children: [
                                                            const Icon(Icons.star, color: Colors.blue),
                                                            const SizedBox(width: 8),
                                                            Text(model.status)
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        padding: const EdgeInsets.all(8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.favorite, color: Colors.blue[500]),
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
                                              "House No- " + model.advertisingId.toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              model.price.toString() + " ৳",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 21),
                                            ),
                                            Text("/Month"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              Icons.bed,
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
                          }),
                      Container(
                        child: Center(
                          child: Text("2"),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text("3"),
                        ),
                      ),
                    ],
                  ),
                  flex: 15,
                )
              ],
            ),
          ),



        ),


      ),
      // bottomNavigationBar: WaterDropNavBar(
      //   backgroundColor: Colors.white,
      //   onItemSelected: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //     pageController.animateToPage(selectedIndex,
      //         duration: const Duration(milliseconds: 400),
      //         curve: Curves.easeOutQuad);
      //   },
      //   selectedIndex: selectedIndex,
      //   barItems: [
      //     BarItem(
      //       filledIcon: Icons.bookmark_rounded,
      //       outlinedIcon: Icons.bookmark_border_rounded,
      //
      //     ),
      //     BarItem(
      //         filledIcon: Icons.favorite_rounded,
      //         outlinedIcon: Icons.favorite_border_rounded),
      //
      //
      //   ],
      //
      // ),
    );


  }



}
