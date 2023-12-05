import 'package:flutter/material.dart';

class UploadText extends StatelessWidget {
  const UploadText({Key? key, this.setUserContent}) : super(key: key);

  final setUserContent;

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (text) {
      setUserContent(text);
    });
  }
}