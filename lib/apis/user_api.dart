import 'package:http/http.dart' as http;

const baseUrlUsers = "https://jsonplaceholder.typicode.com";

class UsersApi {
  static Future getUsers1() async {
    var url = baseUrlUsers + "/users";
    return await http.get(url);
  }
}