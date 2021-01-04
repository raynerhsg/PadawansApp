import 'package:flutter/material.dart';
import 'package:frmproject/apis/posts_api.dart';
import 'package:frmproject/apis/user_api.dart';
import 'package:frmproject/data/PostsDTO.dart';
import 'dart:convert';
import 'package:frmproject/data/UserDTO.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var posts = new List<PostsDTO>();
  var users = new List<UserDTO>();

  _getPosts() {
    PostsApi.getPosts().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        posts = list.map((model) => PostsDTO.fromJson(model)).toList();
        _getUsers();
      });
    });
  }

  _getUsers() {
    UsersApi.getUsers1().then((response) {
      setState(() {
        Iterable list2 = json.decode(response.body);
        users = list2.map((model) => UserDTO.fromJson(model)).toList();
        getUser();
      });
    });
  }

  getUser() {
    for (int i = 0; i < posts.length; i++) {
      for (int j = 0; j < users.length; j++) {
        if (posts[i].id == users[j].id) {
          posts[i].user = users[j];
          break;
        }
      }
    }
  }

  _PostsScreenState() {
    _getPosts();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: _buildPostList(),
    );
  }

  _buildPostList() {
    if (posts.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return new Container(
              margin: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: new Card(
                elevation: 10.0,
                child: new Container(
                  padding: new EdgeInsets.all(12.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 6),
                          Text(
                            posts[index].user.name == null
                                ? 'loading...'
                                : posts[index].user.name,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: new EdgeInsets.symmetric(vertical: 5.0)),
                      Text(
                        this.posts[index].title,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
                      Text(
                        this.posts[index].body,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
