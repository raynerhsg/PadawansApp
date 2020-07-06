import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  var todos = new List<Posts>();
  var user = new List<User1>();

  _getPosts() {
    API.getPosts().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        todos = lista.map((model) => Posts.fromJson(model)).toList();
        _getUsers1();
      });
    });
  }

  _getUsers1() {
    APIuser.getUsers1().then((response) {
      setState(() {
        Iterable lista1 = json.decode(response.body);
        user = lista1.map((model) => User1.fromJson(model)).toList();
        getUsers1();
      });
    });
  }

  getUsers1() {
    for (int i = 0; i < todos.length; i++) {
      for (int j = 0; j < user.length; j++) {
        if (todos[i].id == user[j].id) {
          todos[i].user1 = user[j];
          break;
        }
      }
    }
  }

  _FirstState() {
    _getPosts();
    _getUsers1();
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
        itemBuilder: (context, index) {
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
                    new Text('${todos[index].user1.name}',
                        style: TextStyle(color: Colors.blue[300])),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0)),
                    new Text(
                      '${todos[index].title}',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 6.0)),
                    new Text(
                      '${todos[index].body}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0)),
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
  static Future getPosts() async {
    var url = baseUrl + "/posts";
    return await http.get(url);
  }
}

const baseUrl2 = "https://jsonplaceholder.typicode.com";

class APIuser {
  static Future getUsers1() async {
    var url = baseUrl2 + "/users";
    return await http.get(url);
  }
}

class Posts {
  int userId;
  int id;
  String title;
  String body;
  User1 user1;
  Posts({this.userId, this.id, this.title, this.body, this.user1});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    user1 = User1();
  }
}

class User1 {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User1(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  User1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }
}

class Geo {
  String lat;
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }
}
