
import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert'; // dart에서 제공하는 기본 라이브러리 중 하나, 데이터를 인코딩, 디코딩 하는데 쓰임. (ex. json decode)
import 'package:flutter/rendering.dart'; // 스크롤관련 함수들이 있는 라이브러리


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

  void addData(dynamic newData){
    setState(() {
      data.add(newData);
    });
  }

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
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (c) => Text('새페이지') ) //새 페이지 띄우기: onPressed 클릭 시 페이지 이동
              );
            },
            iconSize: 30,
          )
        ],
      ),
      body: [Home(data : data, addData: addData,), Text('샵'), Text('내정보'),][tab],

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

class Home extends StatefulWidget {
  const Home({Key? key, required this.data, required this.addData})
      : super(key: key);
  final List<dynamic> data;
  final Function(dynamic) addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //23.12.01 scroll 작업
  var scroll = ScrollController();

  void getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        print('맨 밑까지 스크롤 되었음');
        getMore();
      }
    });
  }




  
  @override
  Widget build(BuildContext context) {
    //print(widget.data); 데이터 출력 테스트
    if(widget.data.isNotEmpty){
      return ListView.builder(itemCount: widget.data.length, controller: scroll, itemBuilder: (c, i) { //변수 선언
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${widget.data[i]['image']}'),
              Text('ID: ${widget.data[i]['id']}'),
              Text('Date: ${widget.data[i]['date']}'), // 예를 들어, 날짜를 문자열로 가정
              Row(
                children: [
                  Icon(Icons.favorite_border, color: Colors.black), // 하트 아이콘
                  Text('${widget.data[i]['likes']}'), // 좋아요 수
                ],
              ),
              Text('${widget.data[i]['content']}'),
            ]
        );
      });
    } else {
      return Text('로딩중');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({super.key});

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
