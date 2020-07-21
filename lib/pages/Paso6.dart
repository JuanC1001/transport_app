
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class myDestinos extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<myDestinos> {
  String _mySelection;
  //final String url = "http://informacion.somee.com/api/informacions";
  final String url = "https://jsonplaceholder.typicode.com/posts";
  List data = List(); //edited line
  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
    return "Sucess";
  }
  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
      body: new Center(
        child: new DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              //child: new Text(item['distancia_informacion']),
              child: new Text(item['id']),
              //value: item['tiempo_informacion'].toString(),
              value: item['title'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}

