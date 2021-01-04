import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class PhotosApi {
  static Future getPhotos() async {
    var url = baseUrl + "/photos";
    return await http.get(url);
  }
}