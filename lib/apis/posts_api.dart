import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class PostsApi {
  static Future getPosts() async {
    var url = baseUrl + "/posts";
    return await http.get(url);
  }
}


