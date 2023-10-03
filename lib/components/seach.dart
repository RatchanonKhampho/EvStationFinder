import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LocationSearchDelegate extends SearchDelegate {
  final BuildContext context;

  LocationSearchDelegate(this.context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
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
    // สร้างรายการผลลัพธ์การค้นหาที่เป็นไปได้
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // แสดงรายการค้นหาแบบ dropdown ขณะพิมพ์คำ
    if (query.isNotEmpty) {
      return FutureBuilder<List<DocumentSnapshot>>(
        future: _performSearch(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('เกิดข้อผิดพลาดในการค้นหา');
          }
          final searchResults = snapshot.data;
          return _buildDropdownResults(searchResults);
        },
      );
    } else {
      return Container();
    }
  }

  Future<List<DocumentSnapshot>> _performSearch(String query) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('locations')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();


    return querySnapshot.docs;
  }



  Widget _buildDropdownResults(List<DocumentSnapshot>? searchResults) {
    if (searchResults == null || searchResults.isEmpty) {
      return Center(
        child: Text('ไม่พบผลลัพธ์'),
      );
    }
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index].data() as Map<String, dynamic>;
        return ListTile(
          title: Text(data['name']),
          onTap: () {
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Container(
      // แสดงผลลัพธ์การค้นหาแบบเต็มหน้าจอ
      // คุณสามารถแสดงผลตามความต้องการ
    );
  }
  }
