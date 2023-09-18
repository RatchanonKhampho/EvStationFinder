import 'dart:async';

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
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    GeoFirePoint center =
        geo.point(latitude: 13.751061063636826, longitude: 100.53553028971426);
    var collectionRefence = _firestore.collection('EGAT');
    double radius = 40;
    String field = 'position';

    Stream<List<DocumentSnapshot>> streamOfNearby = geo
        .collection(collectionRef: collectionRefence)
        .within(center: center, radius: radius, field: field);

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<List<DocumentSnapshot>>(
              stream: streamOfNearby,
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Text('No data'),
                  );
                }
                return Container(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      DocumentSnapshot data = snapshot.data![index];
                      return ListTile(
                        title: Text('${data.get('name')}'),
                      );
                    }),
                  ),
                );
              })
        ],
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
