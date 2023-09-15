import 'package:cloud_firestore/cloud_firestore.dart';

class map {
  Map<String, dynamic>? _mapData;

  Future showMarkers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('EGAT')
        .doc(EGAT!.uid)
        .collection('userLocations')
        .get();

    final allData = querySnapshot.docs.map((doc) => doc.get('coords'));

    print(allData);
  }
}