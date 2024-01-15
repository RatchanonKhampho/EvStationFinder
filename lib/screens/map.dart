import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
   final Completer<GoogleMapController> _controller = Completer();
  double zoomVal = 5.0;
  List<DocumentSnapshot> EV = [];
  Set<Polyline> _polylines = {};
  // ติดตาม Marker ที่ถูกแตะ
  Marker? _selectedMarker;
  @override
  void initState() {
    super.initState();
    fetchEV();
    _requestLocationPermission();
  }
 Future<void> fetchEV() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('locations').get();

  // Calculate and set distance for each EV
  for (var doc in snapshot.docs) {
    double lat = doc['latitude'] as double;
    double long = doc['longitude'] as double;
    double distance = await _getDistance(lat, long);

    // Update the document in Firestore using DocumentReference
    FirebaseFirestore.instance.collection('locations').doc(doc.id).update({
      'distance': distance,
      'distanceText': (distance / 1000.0).toStringAsFixed(2) + ' km away',
    });
  }

  // Retrieve the updated data after updating Firestore
  QuerySnapshot updatedSnapshot = await FirebaseFirestore.instance.collection('locations').get();

  // Update EV list
  setState(() {
    EV = updatedSnapshot.docs;
  });
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          if (EV.isNotEmpty) _buildContainer(), // เพิ่มเงื่อนไขตรวจสอบ EV
        ],
            ),
      ),
    );
  }

Future<double> _getDistance(double destinationLat, double destinationLong) async {
  try {
    Position currentPosition = await Geolocator.getCurrentPosition();
    double distanceInMeters = await Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      destinationLat,
      destinationLong,
    );
    return distanceInMeters;
  } catch (e) {
    print('Error getting distance: $e');
    return 0.0;
  }
}
Future<void> _requestLocationPermission() async {
  var status = await Permission.location.request();

  if (status == PermissionStatus.granted) {
    // ทำตามขั้นตอนที่ต้องการทำหลังจากได้รับอนุญาต
    print('Location permission granted');
  } else {
    // แจ้งเตือนหรือทำตามตามที่คุณต้องการเมื่อไม่ได้รับอนุญาต
    print('Location permission denied');
  }
}
Future<void> _gotoLocation(double lat, double long) async {
  final GoogleMapController controller = await _controller.future;

  // ดึงตำแหน่งปัจจุบัน
  Position currentPosition = await Geolocator.getCurrentPosition();
  double currentLat = currentPosition.latitude;
  double currentLong = currentPosition.longitude;

  // เรียกใช้ FlutterPolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();

  // กำหนดตำแหน่งเริ่มและสิ้นสุด
  PointLatLng startLatLng = PointLatLng(currentLat, currentLong);
  PointLatLng endLatLng = PointLatLng(lat, long);

 // ดึงเส้นทาง
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    'AIzaSyDfep5HgNL_RXKAalzR0QAWObeikpqAc9c', // แทน YOUR_GOOGLE_MAPS_API_KEY ด้วย API Key ของคุณ
    startLatLng,
    endLatLng,
    travelMode: TravelMode.driving,
  );

  // ตรวจสอบว่ามีข้อมูลเส้นทาง
  if (result.status == 'OK') {
    // แปลง List<PointLatLng> เป็น List<LatLng>
    List<LatLng> polylineCoordinates = result.points
        .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
        .toList();

    // สร้าง Polyline object
    Polyline polyline = Polyline(
      polylineId: PolylineId('route1'),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    // อัพเดท Set ของ Polylines
    setState(() {
      _polylines.add(polyline);
    });

   // ขยับแผนที่ไปที่ตำแหน่งปลายทาง
  LatLngBounds bounds = LatLngBounds(
    southwest: LatLng(min(currentLat, lat), min(currentLong, long)),
    northeast: LatLng(max(currentLat, lat), max(currentLong, long)),
  );


  CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50.0);

  controller.animateCamera(cameraUpdate);
  }
}

 Widget _buildContainer() {
    // เรียงลำดับ EV ตามระยะห่างก่อนที่จะสร้าง container
    EV.sort((a, b) {
      double distanceA = a['distance'] as double;
      double distanceB = b['distance'] as double;
      return distanceA.compareTo(distanceB);
    });

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: EV.length,
          itemBuilder: (context, index) {
            try {
              String image = EV[index]['images'] as String;
              double lat = EV[index]['latitude'] as double;
              double long = EV[index]['longitude'] as double;
              String EVName = EV[index]['name'] as String;

              return _boxes(image, lat, long, EVName, EV[index]['distanceText'] as String);
            } catch (e) {
              print('Error building container for document ${EV[index].id}: $e');
              return Container(); // หรือแทนด้วยวิดเจ็ตที่ใช้เป็นตัวยึดตำแหน่ง
            }
          },
        ),
      ),
    );
  }
  Widget _boxes(String _image, double lat, double long, String EVName, String distanceText) {
  print('Image: $_image, Lat: $lat, Long: $long, EVName: $EVName, Distance: $distanceText');
  return GestureDetector(
    onTap: () {
      // นำออกตัวระบบนำทาง
      //_gotoLocation(lat, long);
      _moveCameraToMarker(lat, long);
    },
    child: Container(
      padding: EdgeInsets.all(20),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: const Color(0x802196F3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 180,
                height: 200,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(24.0),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(_image),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(EVName),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(distanceText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget myDetailsContainer1(String EVName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(EVName,
            style: const TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }

void _moveCameraToMarker(double lat, double long) async {
  final GoogleMapController controller = await _controller.future;

  // ขยับแผนที่ไปที่ตำแหน่งปลายทาง
  CameraPosition destinationPosition = CameraPosition(
    target: LatLng(lat, long),
    zoom: 15.0,
  );

  controller.animateCamera(CameraUpdate.newCameraPosition(destinationPosition));
}
  Widget _buildGoogleMap(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:  const CameraPosition(target: LatLng(13.755437519298216, 100.50534958162314), zoom: 12),
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: 
           _createMarkers(),
           polylines: _polylines,
          
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
  Set<Marker> markers = Set<Marker>();

  for (int i = 0; i < EV.length; i++) {
    try {
      double lat = EV[i]['latitude'] as double;
      double long = EV[i]['longitude'] as double;
      String name = EV[i]['name'] as String;

      print('Marker: Lat=$lat, Long=$long, Name=$name');

      markers.add(
        Marker(
          markerId: MarkerId(EV[i].id),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
          onTap: () {
              // ตั้งค่า Marker ที่ถูกเลือกเมื่อแตะ
              setState(() {
                _selectedMarker = Marker(
                  markerId: MarkerId(EV[i].id),
                  position: LatLng(lat, long),
                  infoWindow: InfoWindow(title: name),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet,
                  ),
                );
              });

              // แสดง Bottom Sheet พร้อมรายละเอียด
              _showDetailsBottomSheet(EV[i]);
            },
        ),
        
      );
    } catch (e) {
      print('Error creating marker for document ${EV[i].id}: $e');
    }
  }

  return markers;
}
void _showDetailsBottomSheet(DocumentSnapshot evData) {
  showModalBottomSheet(
    context: context,
    builder: (context) {

      return Container(
        height: MediaQuery.of(context).size.height * 0.9, // กำหนดความสูงให้เป็น 90%
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  evData['name'] as String,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  evData['distanceText'] as String,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Image.network(evData['images']),
                SizedBox(height: 8),
                Text(
                  evData['address'] as String,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'เวลา:' + evData['time'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: 8),
                Text(
                  evData['Type'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // นำทางไปยังตำแหน่ง Marker ที่เลือก
                    _gotoLocation(
                      evData['latitude'] as double,
                      evData['longitude'] as double,
                    );
                    Navigator.pop(context); // ปิด Bottom Sheet
                  },
                  child: Text('นำทางไปยังตำแหน่ง'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
}