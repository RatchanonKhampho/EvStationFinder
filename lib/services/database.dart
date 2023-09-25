import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('location').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  }

