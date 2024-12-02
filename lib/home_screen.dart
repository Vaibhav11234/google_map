import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.99,72.82),
    zoom: 14,
  );

  List<Marker> _marker = [];

  List<Marker> _list = const [
    Marker(markerId: MarkerId('1'),position: LatLng(18.99,72.82),
        infoWindow: InfoWindow(
            title: "My Current Location"
        )
    ),
    Marker(markerId: MarkerId('2'),position: LatLng(18.97,72.84),
        infoWindow: InfoWindow(
            title: "E1 sector"
        )
    )
  ];



  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(_list);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 14,target: LatLng(18.99,72.82))));

        },
        child: Icon(Icons.location_searching_outlined),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        // mapType: MapType.normal,
        // myLocationEnabled: true,
        // compassEnabled: true,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),

      ),
    );
  }
}
