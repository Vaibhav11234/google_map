import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  // Set<Marker> _markers = {
  //   Marker(
  //     markerId: MarkerId("1"),
  //     position: LatLng(18.97, 72.80),
  //   )
  // };

  Set<Polygon> _polygon = HashSet<Polygon>();

  //for polygon start point and endpoint must be same in latlng list.

  List<LatLng> points = <LatLng>[
    LatLng(18.97, 72.80),
    LatLng(18.96, 72.81),
    LatLng(18.965, 72.82),
    LatLng(18.95, 72.82),
    LatLng(18.94, 72.81),
    LatLng(18.97, 72.80),
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(Polygon(
        polygonId: PolygonId("1"),
        points: points,
        fillColor: Colors.green.withOpacity(0.3),
        strokeWidth: 4,
        strokeColor: Colors.red));
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
              // markers: _markers,
              onMapCreated: (GoogleMapController controller) {},
              polygons: _polygon,
              // buildingsEnabled: true,

              initialCameraPosition:
                  CameraPosition(target: LatLng(18.97, 72.80), zoom: 14)),
        ],
      ),
    );
  }
}
