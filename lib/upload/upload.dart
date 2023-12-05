// upload.dart
import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({
    Key? key,
    required this.userImage,
    required this.setUserContent,
    required this.addMyData,
  }) : super(key: key);

  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              addMyData();
              Navigator.pop(context);
            },
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.file(userImage),
          ),
          TextField(
            onChanged: (text) {
              setUserContent(text);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
