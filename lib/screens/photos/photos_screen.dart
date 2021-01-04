import 'package:flutter/material.dart';
import 'package:frmproject/apis/photos_api.dart';
import 'package:frmproject/apis/user_api.dart';
import 'package:frmproject/data/PhotosDTO.dart';
import 'dart:convert';

import 'package:frmproject/data/UserDTO.dart';

class PhotosScreen extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<PhotosScreen> {
  var photos = List<PhotosDTO>();
  var users = List<UserDTO>();

  _getPhotos() {
    PhotosApi.getPhotos().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        photos = list.map((model) => PhotosDTO.fromJson(model)).toList();
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
    for (int i = 0; i < photos.length; i++) {
      for (int j = 0; j < users.length; j++) {
        if (photos[i].id == users[j].id) {
          photos[i].user = users[j];
          break;
        }
      }
    }
  }

  _FirstState() {
    _getPhotos();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: _buildPhotosList(),
    );
  }

  _buildPhotosList() {
    if (photos.isEmpty) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
    } else {
      return ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Card(
                elevation: 10.0,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
                          SizedBox(width: 6),
                          Text(
                            photos[index].user.name == null
                                ? 'loading...'
                                : photos[index].user.name,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        photos[index].title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: photos[index].thumbnailUrl == null
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.deepPurple[600]),
                              )
                            : Image.network(
                                photos[index].thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
