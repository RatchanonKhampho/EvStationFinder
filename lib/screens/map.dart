import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _cameraPosition = CameraPosition(target: LatLng(13.812534711489294, 100.5116944),
  zoom: 14);
  List<Marker> _marker = [];
  List<Marker> _List = [
    Marker(markerId: MarkerId('1'),
    position: LatLng(13.812534711489294, 100.5116944),
    infoWindow: InfoWindow(
      title: 'Elex by EGAT สาขา ตึกผู้ว่าการกฟผ.'
    ))
  ];
  @override
  void initState(){
    super.initState();
    _marker.addAll(_List);
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: GoogleMap(
            markers: Set<Marker>.of(_marker),
            initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
          }),

        );
      }

  }