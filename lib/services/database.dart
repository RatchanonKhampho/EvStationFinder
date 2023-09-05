/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_charger/Models/Usermodel.dart';

class Database {
  static Database instance = Database._();
  Database._();
  Future<List> getAllCustomers() async {
    final reference = FirebaseFirestore.instance.collection('User');
    final query = reference.orderBy("uid", descending: true);
    final snapshots = await query.get();
    return snapshots.docs.map(
      (snapshot) => Usermodel.fromMap(snapshot.data()),)
      .toList();
  }
  Future<void> add
}*/