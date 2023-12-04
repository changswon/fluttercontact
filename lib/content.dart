import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('콘텐츠'),
      ),
      body: Center(
        child: Text(
          '여기는 콘텐츠 페이지입니다.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}