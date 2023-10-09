import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  TextEditingController textController = TextEditingController();
  GoogleMapController? _mapController;
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

  // แสดงข้อมูลของหมุดผ่าน BottomSheet
  void _showMarkerDetails(String markerId) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) {
        // ดึงข้อมูลจาก Firestore โดยใช้ markerId
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('locations')
              .doc(markerId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('เกิดข้อผิดพลาดในการดึงข้อมูล');
            }
            final data = snapshot.data!.data() as Map<String, dynamic>;
            // สร้าง UI สำหรับแสดงข้อมูล
            return ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: MediaQuery.of(context).size.height - 30,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Detail',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Image.network('${data['images']}'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'ชื่อ: ${data['name']}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: ListTile(
                          title: Text('ที่อยู่: ${data['address']}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: ListTile(
                          title: Text('เวลา: ${data['time']}'),
                        ),
                      ),

                      // เพิ่มข้อมูลอื่น ๆ ตามที่ต้องการ
                    ],
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
      ),*/
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
              child: Container(
                color: Colors.white,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('ข้อมูลจาก Firestore'),
                    // ใส่โค้ดเพื่อแสดงข้อมูลจาก Firestore ของ _selectedMarkerId ที่เลือก
                  ],
                ),
              ),
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
    return AnimSearchBar(
      width: 400,
      textController: textController,
      onSuffixTap: () {
        setState(() {
          textController.clear();
        });
      },
      onSubmitted: (String) {},
    );
  }
}
