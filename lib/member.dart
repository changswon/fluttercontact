import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class MemberPage extends StatefulWidget {
  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  late List<QueryDocumentSnapshot> docs = []; // 초기화

  getData() async {
    try {
      var result = await firestore.collection('member').get();
      if (result.docs.isNotEmpty) {
        setState(() {
          docs = result.docs.toList();
        });
      } else {
        print('No data available');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (docs.isNotEmpty) {
      return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          var data = docs[index].data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
              title: Text('직급: ${data['level']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름: ${data['name']}'),
                  Row(
                    children: [
                      Icon(Icons.phone_android_outlined, color: Colors.black),
                      Text('${data['phonenumber']}'),
                    ],
                  ),
                  Text('${data['adress']}'),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
