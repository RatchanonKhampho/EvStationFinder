import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LocationSearchDelegate extends SearchDelegate<void> {
  List<DocumentSnapshot> _searchResults = [];
  BuildContext _context;

  LocationSearchDelegate(this._context);

  void _performSearch(String query) {
    FirebaseFirestore.instance
        .collection('locations')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get()
        .then((QuerySnapshot querySnapshot) {
      _searchResults = querySnapshot.docs;
      Scaffold.of(_context).setState(() {}); // อัปเดต UI หลังจากได้ผลลัพธ์ค้นหา
    });
  }


  @override
  List<IconButton> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          _searchResults.clear(); // เคลียร์ผลลัพธ์ค้นหาเมื่อกดปุ่มลบ
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // แสดงผลลัพธ์การค้นหาที่พบ
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final data = _searchResults[index].data() as Map<String, dynamic>;
        return ListTile(
          title: Text(data['name']),
          onTap: () {
            close(context, data);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // แนะนำคำค้นหาที่เกี่ยวข้อง หรือแสดงคำค้นหาล่าสุด ตามที่คุณต้องการ
    return Container();
  }
}
