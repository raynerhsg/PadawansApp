import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Second extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<Second> {
  var todos = new List<Photos>();

  _getTodos() {
    API.getTodos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        todos = lista.map((model) => Photos.fromJson(model)).toList();
      });
    });
  }

  _FirstState() {
    _getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: todoList(),
    );
  }

  todoList() {
    return new ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, index) {
          return new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: new Card(
              elevation: 10.0,
              child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0)),
                    new Text(
                      '${todos[index].id}',
                      style: TextStyle(color: Colors.blue[300], fontSize: 10),
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0)),
                    Center(
                      child: new Image.network(todos[index].url,
                          fit: BoxFit.cover, height: 150.0, width: 150.0),
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0)),
                    new Text(
                      '${todos[index].title}.',
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

const baseUrl = "https://jsonplaceholder.typicode.com";

class API {
  static Future getTodos() async {
    var url = baseUrl + "/photos";
    return await http.get(url);
  }
}

class Photos {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photos({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
