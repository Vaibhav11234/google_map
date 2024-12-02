import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GoogleSearchPlacesScreen extends StatefulWidget {
  const GoogleSearchPlacesScreen({super.key});

  @override
  State<GoogleSearchPlacesScreen> createState() =>
      _GoogleSearchPlacesScreenState();
}

class _GoogleSearchPlacesScreenState extends State<GoogleSearchPlacesScreen> {
  TextEditingController controller = TextEditingController();

  var uuid = Uuid();
  String? _SessionToken;
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_SessionToken == null) {
      setState(() {
        _SessionToken = uuid.v4();
      });
    }
    getSuggetion(controller.text);
  }

  void getSuggetion(String inputtext) async {
    String API_KEY = "AIzaSyBRqq3gExi_yi-NYbY3hDNXG3I86b6SVmU";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$inputtext&key=$API_KEY&sessiontoken=$_SessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body)['predictions'];
      });
    } else {
      throw Exception("Failed to load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Places"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Search Places with name"),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (builder, index) {
                    return ListTile(
                      title: _placesList[index]['description'],
                    );
                  }))
        ],
      ),
    );
  }
}
