import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(18.98, 72.80), zoom: 14);

  Uint8List? markerImage;
  List<String> imageList = [
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
  ];

  final List<Marker> _markers = [];
  final List<LatLng> _latlngList = <LatLng>[
    LatLng(18.97, 72.80),
    LatLng(18.96, 72.80),
    LatLng(18.965, 72.80),
    LatLng(18.95, 72.80),
    LatLng(18.94, 72.80),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void loadData() async {
    for (int i = 0; i < imageList.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(imageList[i], 100);
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.bytes(markerIcon),
          position: _latlngList[i],
          infoWindow: InfoWindow(title: "This is $i Marker")));
      setState(() {});
    }
    print("aiojsi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Marker"),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      ),
    );
  }
}
