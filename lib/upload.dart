import 'package:flutter/material.dart';


class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지 업로드 화면'),
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)
          ),
        ],
      ),
    );
  }
}
