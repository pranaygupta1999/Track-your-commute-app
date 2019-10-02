import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'config.dart';
class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) async {
      try {
        var response = await http.get(Config.SERVER_IP+"/location");
        var jsonResponse = json.decode(response.body);
        setState(() {
          position =
              LatLng(jsonResponse['latitude'], jsonResponse['longitude']);
               mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target:position ,
                  zoom: 20)));
        });
      } catch (e) {}
    });
  }

  GoogleMapController mapController;
  LatLng position = LatLng(27.302, 28.932);
  @override
  Widget build(BuildContext context) {
    print("Created Map widget");
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: position, zoom: 20),
          markers: Set<Marker>.from(
              [Marker(markerId: MarkerId("1"), position: position)]),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),

    );
  }
}
