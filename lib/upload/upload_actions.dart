import 'package:flutter/material.dart';

class UploadActions extends StatelessWidget {
  const UploadActions({Key? key, this.addMyData}) : super(key: key);

  final addMyData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        addMyData();
      },
      icon: Icon(Icons.send),
    );
  }
}