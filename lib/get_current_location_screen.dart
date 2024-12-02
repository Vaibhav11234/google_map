import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Getcurrentlocationscreen extends StatefulWidget {
  const Getcurrentlocationscreen({super.key});

  @override
  State<Getcurrentlocationscreen> createState() =>
      _GetcurrentlocationscreenState();
}

class _GetcurrentlocationscreenState extends State<Getcurrentlocationscreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(18.98, 72.80), zoom: 14);

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(title: "The title of the marker"),
        position: LatLng(18.98, 72.80)),
  ];

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error:-${error}");
    });
    return await Geolocator.getCurrentPosition();
  }

  // loadData() {
  //   getCurrentLocation().then((position) async {
  //     _markers.add(Marker(
  //         markerId: MarkerId("2"),
  //         infoWindow: InfoWindow(title: "My Current Location"),
  //         position: LatLng(position.latitude, position.longitude)));
  //     CameraPosition cameraPosition =
  //         CameraPosition(target: LatLng(position.latitude, position.longitude));
  //
  //     final GoogleMapController controller = await _controller.future;
  //
  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("vaibhav");
          getCurrentLocation().then((position) async {
            _markers.add(Marker(
                markerId: MarkerId("2"),
                infoWindow: InfoWindow(title: "My Current Location"),
                position: LatLng(position.latitude, position.longitude)));

            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14);

            final GoogleMapController controller = await _controller.future;

            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
            print("complete");
          });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
