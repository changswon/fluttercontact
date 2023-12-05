import 'package:flutter/material.dart';


class Uploadimage extends StatelessWidget {
  const Uploadimage({Key? key, this.userImage}) : super(key: key);

  final userImage;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Image.file(userImage),
    );
  }
}