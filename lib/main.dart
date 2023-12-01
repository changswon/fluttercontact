
import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MaterialApp(
      theme: style.theme,
      home: MyApp()
  )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  getData() async {
    try {
      var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));

      if (result.statusCode == 200) {
        var result2 = jsonDecode(result.body);
        setState(() {
          data = result2;
        });
      } else {
        print('서버 응답이 성공하지 않았습니다. 응답 코드: ${result.statusCode}');
      }
    } catch (error) {
      print('서버 통신 중 에러가 발생했습니다: $error');
    }
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
            icon:Icon(Icons.add_box_outlined),
            onPressed: (){},
            iconSize: 30,
          )
        ],
      ),
      body: [Home(data : data), Text('샵'), Text('내정보'),][tab],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈', tooltip: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵', tooltip: '샵'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: '내정보', tooltip: '내정보'),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    print(data);
    if(data.isNotEmpty){
      return ListView.builder(itemCount: 3, itemBuilder: (c, i) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${data[i]['image']}'),
              Text('ID: ${data[i]['id']}'),
              Text('Date: ${data[i]['date']}'), // 예를 들어, 날짜를 문자열로 가정
              Row(
                children: [
                  Icon(Icons.favorite_border, color: Colors.black), // 하트 아이콘
                  Text('${data[i]['likes']}'), // 좋아요 수
                ],
              ),
              Text('${data[i]['content']}'),
            ]
        );
      });
    } else {
      return Text('로딩중');
    }
  }
}