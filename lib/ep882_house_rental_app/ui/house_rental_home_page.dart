import 'dart:convert';

import 'package:client_mobile/ep882_house_rental_app/model/AdvertiseModel.dart';
import 'package:client_mobile/ep882_house_rental_app/model/house.dart';
import 'package:client_mobile/helper/http_helper.dart';
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


  static const snackBar = SnackBar(
    content: Text('Get Advertise SuccessFully '),
  );


  getAdvertising() async{
    final res = await _http.getData("http://192.168.0.104:9092/getAddvertising");
    if(res.statusCode == 200){
     Map<dynamic, dynamic>  data = json.decode(res.body);
     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
     List<dynamic> dataList= data['data'];
     this.advertise = dataList.map((e) => AdvertiseModel.fromMap(e)).toList();
     setState(() {
       this.advertise;
     });
    }

  }




  @override
  void initState() {
    // TODO: implement initState

      //super.initState();
     _tabController = TabController(length: 3, vsync: this);
     getAdvertising();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("House Rental Management"), centerTitle: true,),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Search", icon: Icon(Icons.search), border: InputBorder.none),
                              ),
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed("/search/filter"),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
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
                flex: 2,
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
                  Tab(text: "Nearest"),
                  Tab(text: "Popular"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        //itemCount: this.advertise.length,
                        itemCount: houseItems.length,
                        itemBuilder: (context, index) {
                          // AdvertiseModel model =  this.advertise[index];
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
                                                      image: NetworkImage(houseItems[index].img ?? ""),
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
                                                          Text(houseItems[index].star ?? "")
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
                                            "${houseItems[index].title}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text(
                                            "${houseItems[index].pricePerNight}",
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
                                            "${houseItems[index].location}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.bed,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "${houseItems[index].rooms}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.crop_square,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "${houseItems[index].area}",
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
    );
  }
}
