import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> sendPostRequest(String email) async {
  var url = Uri.parse('http://192.168.137.216:8080/userAuth');
  var headers = <String, String>{'email': email};

  var response = await http.post(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    int userId = jsonResponse['userId'];
    print('UserId: $userId');
    return userId;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to fetch user ID'); // Добавлено исключение в случае ошибки
  }
}