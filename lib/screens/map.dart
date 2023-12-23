import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  List<DocumentSnapshot> _searchResults = [];
  List<DocumentSnapshot> _allLocations = [];
  Position? _currentPosition;
  bool _showFilteredMarkers = false;
  String _location = "Press the FAB to get location";
  // ตั้งค่าพิกัดเริ่มต้น
  static const LatLng _initialCameraPosition = const LatLng(13.7563, 100.5018);
  List<Marker?> _markers = [];
  bool _bottomSheetVisible = false;
  String _selectedMarkerId = "";
  var _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirestore();
    _getCurrentLocation();
    _requestPermission();
  }

  bool _filterActive = false;

  void _toggleFilter() {
    setState(() {
      _filterActive = !_filterActive;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });

      if (_mapController != null) {
        // Animate camera to current location
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // ดึงข้อมูลหมุดจาก Firestore และสร้าง Marker
  Future<void> _loadMarkersFromFirestore() async {
    final markers =
        await FirebaseFirestore.instance.collection('locations').get();
    setState(() {
      _markers = markers.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final LatLng position = LatLng(data['latitude'], data['longitude']);

            // เช็คว่าข้อมูลหมุดต้องมีเงื่อนไขที่คุณต้องการกรองหรือไม่
            if (_filterActive) {
              // ตรวจสอบเงื่อนไขกรอง ยกตัวอย่างเช่น 'category' คือชื่อของฟิลด์ที่คุณใช้ในการกรอง
              if (data['Type'] == 'Type 1') {
                return Marker(
                  markerId: MarkerId(doc.id),
                  position: position,
                  onTap: () => _showMarkerDetails(doc.id),
                );
              } else {
                return null; // ถ้าไม่ตรงเงื่อนไขจะไม่สร้าง Marker
              }
            } else {
              // ถ้าไม่มีการกรองให้สร้าง Marker ทุกตัว
              return Marker(
                markerId: MarkerId(doc.id),
                position: position,
                onTap: () => _showMarkerDetails(doc.id),
              );
            }
          })
          .where((marker) => marker != null)
          .toList();

      // อัพเดต _allLocations
      _allLocations = markers.docs;
    });
  }

  void _showMarkerDetails(String markerId) {
    setState(() {
      _selectedMarkerId = markerId;
    });
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('locations')
              .doc(_selectedMarkerId)
              .get(),
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Text(
                        "Detail",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Image.network('${data['images']}'),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: ListTile(
                    leading: Image.network('${data['logo']}'),
                    title: Text('ชื่อ: ${data['name']}'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: Colors.blue,
                    ),
                    title: Text('ที่อยู่: ${data['address']}'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.timer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text('เวลา: ${data['time']}'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: ListTile(
                    leading: Image.network(
                      data['type images'],
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Type: ${data['Type']}'),
                  ),
                ),
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
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialCameraPosition,
              zoom: 15,
            ),
            // ตั้งค่าให้ user สามารถเลื่อนแผนที่ได้
            myLocationEnabled: false,
            // ตั้งค่าให้ user สามารถขยาย/ย่อ แผนที่ได้
            zoomControlsEnabled: false,
            compassEnabled: true,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
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
        ]),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAllLocations();
        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
          if (_currentPosition != null) {
            _scrollToCurrentLocation();
          }
        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  // เลื่อนมุมมองไปยังตำแหน่งปัจจุบัน
  // เลื่อนมุมมองไปยังตำแหน่งปัจจุบัน
  void _scrollToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    } else {
      // ทำบางสิ่งเมื่อ _currentPosition ไม่ได้รับค่า
    }
  }

  void _performSearch(String query) {
    FirebaseFirestore.instance
        .collection('locations')
        .where('keywords', arrayContainsAny: [query.toLowerCase()])
        .get()
        .then((QuerySnapshot querySnapshot) {
          setState(() {
            _searchResults = querySnapshot.docs;
            _bottomSheetVisible = true;
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

    // ปิด BottomSheet ที่แสดงผลลัพธ์การค้นหา
    setState(() {
      _bottomSheetVisible = false;
    });
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true, // ตั้งค่า shrinkWrap เป็น true
        physics:
            NeverScrollableScrollPhysics(), // ตั้งค่า physics เป็น NeverScrollableScrollPhysics
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

  void _showAllLocations() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: _allLocations.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return ListTile(
              leading: Image.network(
                '${data['logo']}',
                width: 50,
                height: 50,
              ),
              title: Text('${data['name']}'), // แสดงชื่อสถานที่
              onTap: () {
                // ปิด BottomSheet และทำอะไรกับสถานที่ที่เลือก (เช่น นำคุณไปยังสถานที่นั้น)
                final LatLng position =
                    LatLng(data['latitude'], data['longitude']);
                _mapController!.animateCamera(CameraUpdate.newLatLng(position));
                setState(() {
                  _bottomSheetVisible = false;
                });

                // คืนค่า Navigator เพื่อปิด BottomSheet
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      },
    );
  }
}
