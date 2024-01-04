import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';



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
  @override
  void initState() {
    super.initState();
    fetchEV();
  }
  Future<void> fetchEV() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('locations').get();
  setState(() {
    EV = snapshot.docs;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              //
            }),
        actions: <Widget>[
          IconButton(
              icon: const Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
      children: <Widget>[
        _buildGoogleMap(context),
        if (EV.isNotEmpty) _buildContainer(), // เพิ่มเงื่อนไขตรวจสอบ EV
      ],
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

            return FutureBuilder<double>(
              future: _getDistance(lat, long),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double distanceInMeters = snapshot.data!;
                  double distanceInKilometers = distanceInMeters / 1000.0;
                  String distanceText = distanceInKilometers.toStringAsFixed(2) + ' km away';

                  return _boxes(image, lat, long, EVName, distanceText);
                } else {
                  return Container();
                }
              },
            );
          } catch (e) {
            print('Error building container for document ${EV[index].id}: $e');
            return Container(); // or replace with a placeholder widget
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
      _gotoLocation(lat, long);
    },
        child:Container(
          padding: EdgeInsets.all(20),
              child: new FittedBox(
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
                          ),),
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
                          )
                          
                      ],)
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

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  const CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
        myLocationEnabled: true,
        
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: 
         _createMarkers(),
         polylines: _polylines,
        
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
          infoWindow: InfoWindow(title: name),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
        ),
      );
    } catch (e) {
      print('Error creating marker for document ${EV[i].id}: $e');
    }
  }

  return markers;
}


}
