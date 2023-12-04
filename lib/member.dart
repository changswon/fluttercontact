import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원목록'),
      ),
      body: Center(
        child: Text(
          '멤버목록',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}