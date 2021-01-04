import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class TodosApi {
  static Future getTodos() async {
    var url = baseUrl + "/todos";
    return await http.get(url);
  }
}
