import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Third extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<Third> {
  var todos = new List<Todos>();

  _getTodos() {
    API.getTodos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        todos = lista.map((model) => Todos.fromJson(model)).toList();
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
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text(
                      '${todos[index].id}' ': ${todos[index].title}.',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    Column(
                      children: <Widget>[
                        new ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                            ),
                            child: Container(
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    todos[index].completed
                                        ? 'assets/check.png'
                                        : 'assets/unchecked-checkbox.png',
                                    width: 17.5,
                                    height: 17.5,
                                    scale: 10,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
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
    var url = baseUrl + "/todos";
    return await http.get(url);
  }
}

class Todos {
  int userId;
  int id;
  String title;
  bool completed;

  Todos({this.userId, this.id, this.title, this.completed});

  Todos.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
}
