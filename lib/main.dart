import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://swapi.co/api/people";
  List data ;

  @override
  void initState(){
    super.initState();
     this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState(() {
      var ConvertDataToJson = jsonDecode(response.body);
      data = ConvertDataToJson['results'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Fetching_Data_App"),
      ),
      body: new ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context , int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              )
            ),
          );
        }

      ),
    );
  }
}

