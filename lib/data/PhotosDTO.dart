import 'package:frmproject/data/UserDTO.dart';

class PhotosDTO {
  int albumId;
  int id;
  String title;
  String url;
  UserDTO user;
  String thumbnailUrl;

  PhotosDTO({this.albumId, this.id, this.title, this.url, this.thumbnailUrl, this.user});

  PhotosDTO.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    user = UserDTO();
  }
}

