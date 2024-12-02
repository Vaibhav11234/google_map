import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customMarkerInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(18.97, 72.80),
    )
  };
  final List<LatLng> _latlngList = <LatLng>[
    LatLng(18.97, 72.80),
    LatLng(18.96, 72.80),
    LatLng(18.965, 72.80),
    LatLng(18.95, 72.80),
    LatLng(18.94, 72.80),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlngList.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latlngList[i],
          onTap: () {
            _customMarkerInfoWindowController.addInfoWindow!(
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                          image: NetworkImage(
                              'https://image.shutterstock.com/image-vector/dotted-spiral-vortex-royaltyfree-images-600w-2227567913.jpg'))
                    ],
                  ),
                ),
                _latlngList[i]);
          }));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Marker InfoWindow"),
      ),
      body: Stack(
        children: [
          GoogleMap(
              onTap: (position) {
                _customMarkerInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customMarkerInfoWindowController.onCameraMove!();
              },
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _customMarkerInfoWindowController.googleMapController =
                    controller;
              },
              // buildingsEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(18.97, 72.80), zoom: 14)),
          CustomInfoWindow(
            controller: _customMarkerInfoWindowController,
            height: 200,
            width: 300,
            offset: 25,
          )
        ],
      ),
    );
  }
}
