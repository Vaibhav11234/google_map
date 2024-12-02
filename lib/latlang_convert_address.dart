import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/services/base.dart';
import 'package:geocoding/geocoding.dart';












//Above package is not useful for Android above certain












class LatlangConvertAddress extends StatefulWidget {
  const LatlangConvertAddress({super.key});

  @override
  State<LatlangConvertAddress> createState() => _LatlangConvertAddressState();
}

class _LatlangConvertAddressState extends State<LatlangConvertAddress> {
  String? _address = '';
  String? _address1 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_address!),
          GestureDetector(
            onTap: ()async{
              final coordinates = Coordinates(18.99,72.82);

              List<Location> locations = await locationFromAddress("India");

              var address = await placemarkFromCoordinates(18.99,72.82);

              //Below package is not useful , not used in higher android.
              // var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
              // print("---${address.first.addressLine}  ${address.first.featureName}");
              print("---${address.first.name} ${address.first.administrativeArea} ${address.first.country}${address.first.locality} ${address.first.postalCode}");
              setState(() {
                // _address = address.first.addressLine;
                _address = locations.first.latitude.toString();

              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Get Address",style: TextStyle(
                      fontSize: 25
                  ),)),
                ),
                decoration: BoxDecoration(
                    color: Colors.lightBlue
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
