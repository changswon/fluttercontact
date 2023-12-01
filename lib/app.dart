import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'home.dart';
import 'upload.dart';
import 'http_helper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  void addData(dynamic newData) {
    setState(() {
      data.add(newData);
    });
  }

  void getData() async {
    data = await HttpHelper.fetchData('https://codingapple1.github.io/app/data.json');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => Upload()),
              );
            },
            iconSize: 30,
          )
        ],
      ),
      body: [Home(data: data, addData: addData), Text('샵'), Text('내정보')][tab],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈', tooltip: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵', tooltip: '샵'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보', tooltip: '내정보'),
        ],
      ),
    );
  }
}
