import 'package:frmproject/data/PhotosDTO.dart';
import 'package:frmproject/data/UserDTO.dart';

class PostsDTO {
  int userId;
  int id;
  String title;
  String body;
  UserDTO user;
  PostsDTO({this.userId, this.id, this.title, this.body, this.user});

  PostsDTO.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    user = UserDTO();
  }
}

