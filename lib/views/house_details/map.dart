import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HouseMap extends StatefulWidget {
  final lat;
  final lng;

  const HouseMap({Key? key, this.lat, this.lng}) : super(key: key);

  @override
  _HouseMapState createState() => _HouseMapState();
}

class _HouseMapState extends State<HouseMap> {

 // CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(lat, 90.376015),  zoom: 15.0,);

// add this to control the Map
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Marker> _markers = [];
    _markers.add(
        Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(widget.lat,widget.lng),
            infoWindow: InfoWindow(
                title: 'Hello there.  I am here '
            )
        )
    );

    return Container(
      height: height,
      width: width,
        child: Scaffold(
        body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.lng),
              zoom: 15.0,
            ),
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
