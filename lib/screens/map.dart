import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  GoogleMapController? _controller;
  Set<Marker> _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(13.812534711489294,100.5116944), // ตำแหน่งเริ่มต้นของแผนที่
            zoom: 15.0, // ขนาดภาพ
          ),
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
            _loadMarkersFromFirestore();
          },
          markers: _markers,
        ),
      ],
    );
    /*bottomNavigationBar: SalomonBottomBar(
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
        ));*/
  }

// โหลดข้อมูลจาก Firestore และสร้างหมุดบนแผนที่
  void _loadMarkersFromFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('locations').get();

    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final lat = data['latitude'] as double;
      final lng = data['longitude'] as double;
      final marker = Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: data['name'] ?? '',
          snippet: data['description'] ?? '',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
