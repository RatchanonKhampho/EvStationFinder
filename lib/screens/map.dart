import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  List<DocumentSnapshot> _searchResults = [];

  // ตั้งค่าพิกัดเริ่มต้น
  static const LatLng _initialCameraPosition = const LatLng(13.7563, 100.5018);
  List<Marker> _markers = [];
  bool _bottomSheetVisible = false;
  String _selectedMarkerId = "";
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirestore();
  }

  // ดึงข้อมูลหมุดจาก Firestore และสร้าง Marker
  Future<void> _loadMarkersFromFirestore() async {
    final markers =
        await FirebaseFirestore.instance.collection('locations').get();
    setState(() {
      _markers = markers.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final LatLng position = LatLng(data['latitude'], data['longitude']);
        return Marker(
          markerId: MarkerId(doc.id),
          position: position,
          onTap: () => _showMarkerDetails(doc.id),
        );
      }).toList();
    });
  }

  void _showMarkerDetails(String markerId) {
    setState(() {
      _selectedMarkerId = markerId;
    });
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('locations').doc(_selectedMarkerId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('เกิดข้อผิดพลาดในการดึงข้อมูล');
            }
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              shrinkWrap: true,
              children: [
                Image.network('${data['images']}'),
                ListTile(
                  title: Text('ชื่อ: ${data['name']}'),
                ),
                ListTile(
                  title: Text('ที่อยู่: ${data['address']}'),
                ),
                ListTile(
                  title: Text('เวลา: ${data['time']}'),
                ),
                // เพิ่มข้อมูลอื่น ๆ ตามที่ต้องการ
              ],
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialCameraPosition,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            markers: Set<Marker>.from(_markers),
          ),
          if (_bottomSheetVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildSearchResults(),
            ),
          Column(
            children: [
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                child: seachBar(),
              )),
            ],
          ),
        ]),
      ),
    );
  }

  Widget seachBar() {
    return TextField(
      controller: _searchController,
      onChanged: (query) => _performSearch(query),
      decoration: InputDecoration(
        labelText: 'ค้นหา',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  void _performSearch(String query) {
    FirebaseFirestore.instance
        .collection('locations')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _searchResults = querySnapshot.docs;
        _bottomSheetVisible = true; // ทำให้ BottomSheet แสดงผล
      });
    });
  }



  // คำนวณขอบเขตของหมุดทั้งหมด
  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double south = 90;
    double west = 180;
    double north = -90;
    double east = -180;

    for (LatLng latLng in list) {
      if (latLng.latitude < south) south = latLng.latitude;
      if (latLng.longitude < west) west = latLng.longitude;
      if (latLng.latitude > north) north = latLng.latitude;
      if (latLng.longitude > east) east = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  void _selectSearchResult(DocumentSnapshot result) {
    final data = result.data() as Map<String, dynamic>;
    final LatLng position = LatLng(data['latitude'], data['longitude']);

    // ย้ายกล้องให้ชี้ที่ตำแหน่งของหมุด
    _mapController!.animateCamera(CameraUpdate.newLatLng(position));

    // แสดงข้อมูลของหมุดที่เลือกผ่าน BottomSheet
    _showMarkerDetails(result.id);
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final data = _searchResults[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name']),
            onTap: () => _selectSearchResult(_searchResults[index]),
          );
        },
      ),
    );
  }
}
