import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  GoogleMapController? mapController;

  final LatLng _center = LatLng(13.812534711489294, 100.5116944);

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center,zoom: 11.0),
      ),
    );
  }
}
