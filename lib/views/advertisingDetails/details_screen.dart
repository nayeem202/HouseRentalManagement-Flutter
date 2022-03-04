
import 'package:client_mobile/views/advertisingDetails/components/house.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/carousel_images.dart';
import 'components/custom_app_bar.dart';
import 'components/house_details.dart';

class DetailsScreen extends StatefulWidget {

  final House house;

  const DetailsScreen({required Key key, required this.house}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  CarouselImages(widget.house.moreImagesUrl),
                  CustomAppBar(),
                ],
              ),
              HouseDetails(widget.house),
            ],
          ),
        ],
      ),
    );
  }
}
