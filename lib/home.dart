// lib/home.dart
import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key, required this.data, required this.addData}) : super(key: key);
  final List<dynamic> data;
  final Function(dynamic) addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  void getMore() async {
    try {
      var result = await HttpHelper.fetchData('https://codingapple1.github.io/app/more1.json');
      List<dynamic> result2 = jsonDecode(result);
      widget.addData(result2);
    } catch (error) {
      print('데이터 로딩 중 오류: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('맨 밑까지 스크롤 되었음');
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.data.length,
        controller: scroll,
        itemBuilder: (c, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${widget.data[i]['image']}'),
              Text('ID: ${widget.data[i]['id']}'),
              Text('Date: ${widget.data[i]['date']}'),
              Row(
                children: [
                  Icon(Icons.favorite_border, color: Colors.black),
                  Text('${widget.data[i]['likes']}'),
                ],
              ),
              Text('${widget.data[i]['content']}'),
            ],
          );
        },
      );
    } else {
      return Text('로딩중');
    }
  }
}
