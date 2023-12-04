import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() {
  runApp(MaterialApp(
    theme: style.theme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];
  var userImage;
  var userContent;
  bool isLoading = true;

  addMyData(){
   var myData = {
    'id': data.length,
    'image': userImage,
    'likes':5,
    'date':'July 25',
    'content': userContent,
    'liked': false,
    'user': 'John Kim'
   };
   setState(() {
     data.insert(0, myData);
   });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

  void addData(dynamic newData) {
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
          isLoading = false;
        });
      } else {
        print('서버 응답이 성공하지 않았습니다. 응답 코드: ${result.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('서버 통신 중 에러가 발생했습니다: $error');
      setState(() {
        isLoading = false;
      });
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
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery); // 카메라로 바꾸고싶으면 .camera
              if (image != null) {
                setState((){
                  userImage = File(image.path);
                });
              }
              Navigator.push(context,
                MaterialPageRoute(builder: (c) => Upload(
                  userImage : userImage,
                  setUserContent : setUserContent,
                  addMyData : addMyData,
                ))
              );
            },
            iconSize: 30,
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(),
      )
          : [Home(data: data, addData: addData,), Text('샵'), Text('내정보')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: '홈', tooltip: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: '샵', tooltip: '샵'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: '내정보', tooltip: '내정보'),
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
  var scroll = ScrollController();

  void getMore() async {
    var result =
    await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
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
              widget.data[i]['image'].runtimeType == String
                  ? Image.network(widget.data[i]['image'])
                  : Image.file(widget.data[i]['image']),  //3항 연산
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
      return Center(child: CircularProgressIndicator());
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData}) : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addMyData();
          }, icon:Icon(Icons.send))
        ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.file(userImage),
          ),

          TextField(onChanged: (text){ setUserContent(text); }),
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
