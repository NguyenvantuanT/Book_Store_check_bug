import 'package:http/http.dart' as http;

class ApiServices {
  Future get books async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=Fiction&maxResutsl=40");
    final response = await http.get(url);
    return response.body;
  }

  Future searchBook({required String searchBook}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$searchBook&maxResults=39");
    final response = await http.get(url);
    return response.body;
  }

  Future detailBook({String? id}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes/$id");
    final response = await http.get(url);
    return response.body;
  }

  Future  getTitleBook({required String categories}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$categories&maxResults=39");
    final response = await http.get(url);
    return response.body;
  }
}
