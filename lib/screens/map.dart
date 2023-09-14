import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  var _currentIndex = 0;
 late StreamSubscription _locationSubcription;
 late Marker marker;
 late Circle circle;
 late GoogleMapController _controller;

 late String location;
 RxList maplist = <OfferModel>[].obs;
 var isloading = true.obs;

 final Ev = FirebaseFirestore.instance.collection('EGAT');
 Map<MarkerId, Marker> markers = <MarkerId , Marker> {

 };

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  void initOffer(specify, specifyId) async
  {
    var p=specify['position'];
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(p['position'].latitude, p['position'].longitutde),
        infoWindow: InfoWindow(title: specify['name'], snippet: specify['position'])
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<DocumentReference> getMarkerData() async {
    try {
      allOfferCollection.get().then((snapshot) {
        print(snapshot);
        if(snapshot.docs.isNotEmpty){
          for(int i= 0; i < snapshot.docs.length; i++)
          {
            initOffer(snapshot.docs[i].data, snapshot.docs[i].id);
          }
        }
        snapshot.docs
            .where((element) => element["location"] == location)
            .forEach((element) {
          if (element.exists) {
            mapList.add(OffersModel.fromJson(element.data(), element.id));
          }
        });
      });
    } finally {
      isLoading(false);
    }
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(36.723062, 3.087800),
    zoom: 14.4746,
    // zoom: 14,

  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/marker.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));

    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00
          )));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(

          )],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
            selectedColor: Colors.black,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.qr_code),
            title: Text(""),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.wallet),
            title: Text(""),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person_2_rounded),
            title: Text(""),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }


}
