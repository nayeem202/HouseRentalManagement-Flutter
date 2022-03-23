import 'package:carousel_pro/carousel_pro.dart';
import 'package:client_mobile/ep882_house_rental_app/model/AdvertiseModel.dart';
import 'package:client_mobile/views/advertisingDetails/components/carousel_images.dart';
import 'package:client_mobile/views/house_details/bottom_buttons.dart';
import 'package:client_mobile/views/house_details/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../helper/constant.dart';
import '../advertisingDetails/components/constants.dart';

class HouseInfo extends StatefulWidget {
  final advertisingId;
  final location;
  final type;
  final status;
  final bedrooms;
  final bathrooms;
  final price;
  final sqft;
  final additionalinformation;
  final images;
  final imagesUri;
  final img2;
  final imgUri2;
  final img3;
  final imgUri3;
  final video;
  final videoType;
  final lat;
  final lng;
  final username;
  final name;
  final phone;
  final email;

  //HouseInfo({Key? key, required int advertisingId, required String location, required String status, required String type, required int bedrooms, required int bathrooms, required int price, required int sqft, required String additionalinformation, required String images,required String imagesUri, required String img2, required String imgUri2, required String img3, required String imgUri3, required String video, required String videoType, required double lat, required double lng}) : super(key: key);
  const HouseInfo(
      {this.location,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.advertisingId,
      this.type,
      this.status,
      this.bedrooms,
      this.bathrooms,
      this.price,
      this.sqft,
      this.additionalinformation,
      this.images,
      this.imagesUri,
      this.img2,
      this.imgUri2,
      this.img3,
      this.imgUri3,
      this.video,
      this.videoType,
      this.lat,
      this.lng});

  @override
  _HouseInfoState createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
       //widget.imagesUri.toString().replaceAll("http://localhost:9092", host)
        "${widget.video.toString().replaceAll("http://localhost:9092", host)}")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Stack(children: [
              Container(
                height: size.height * 0.35,
                child: Carousel(
                  dotSize: 5,
                  dotBgColor: Colors.transparent,
                  autoplay: true,
                  images: [
                    NetworkImage(
                      widget.imagesUri.toString().replaceAll("http://localhost:9092", host),
                      //widget.imagesUri.replaceAll("http://localhost:9092", host)}",
                    ),
                    NetworkImage(
                      widget.imgUri2.toString().replaceAll("http://localhost:9092", host),
                     //"${widget.imgUri2.replaceAll("http://localhost:9092", host)}",
                    ),
                    NetworkImage(
                      widget.imgUri3.toString().replaceAll("http://localhost:9092", host),
                      //"${widget.imgUri3.replaceAll("http://localhost:9092", host)}",
                    ),
                  ],
                ),
              ),
            ]),
            Expanded(
                child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    left: appPadding,
                    right: appPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.location_on_outlined, size: 14),
                                ),
                                TextSpan(
                                  text: (" ${widget.location}"),
                                  style: TextStyle(color : Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),

                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            (" ৳ ${widget.price}"),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ("${widget.type}"),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: appPadding, bottom: 20),
                        child: Text(
                          ("Additional Information"),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 60.0, bottom: 20, right: 10
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HouseMap(lat: widget.lat, lng: widget.lng)));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 15.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'See location',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),

                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: appPadding,
                          bottom: appPadding,
                        ),
                        child: Container(
                          width: 100,
                          //height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: black.withOpacity(0.4),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ("Sqft- ${widget.sqft}"),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: appPadding,
                          bottom: appPadding,
                        ),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: black.withOpacity(0.4),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ("Bedrooms - ${widget.bedrooms}"),
                                //widget.house.bedRooms.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: appPadding,
                          bottom: appPadding,
                        ),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: black.withOpacity(0.4),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ("Bathrooms - ${widget.bathrooms}"),
                                //widget.house.bathRooms.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: appPadding,
                          bottom: appPadding,
                        ),
                        child: Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: appPadding,
                    right: appPadding,
                    bottom: appPadding,
                  ),
                  child: Text(
                    ("Description - ${widget.additionalinformation}"),
                    //widget.house.description,
                    style: TextStyle(
                      color: black.withOpacity(0.4),
                      height: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: appPadding, bottom: appPadding),
                  child: Text(
                    'Virtual Tour',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10, right: 10
                  ),
                  child: Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20, bottom: 20
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      )),
                ),
                    BottomButtons(name: widget.name, email: widget.email, phone: widget.phone

                    ),
              ],
            )
            )
          ],
        )
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
