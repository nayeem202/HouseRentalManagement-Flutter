import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HouseMap extends StatefulWidget {
  const HouseMap({Key? key}) : super(key: key);

  @override
  _HouseMapState createState() => _HouseMapState();
}

class _HouseMapState extends State<HouseMap> {
  CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(23.746466, 90.376015));

// add this to control the Map
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
        child: Scaffold(
        body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _initialCameraPosition ,
            mapToolbarEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController c) {
              // to control the camera position of the map
              googleMapController = c;
            },
          ),
        ],
    ),
    )
    );
  }
}
