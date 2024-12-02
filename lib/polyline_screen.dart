import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({super.key});

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(18.97, 72.80), zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = <LatLng>[
    LatLng(18.97, 72.80),
    LatLng(18.96, 72.81),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(title: "Really cool place")));
    }
    _polyline.add(
      Polyline(polylineId: PolylineId('1'), points: latlng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polyline"),
      ),
      body: GoogleMap(
        polylines: _polyline,
        markers: _markers,
        initialCameraPosition: _cameraPosition,
      ),
    );
  }
}
