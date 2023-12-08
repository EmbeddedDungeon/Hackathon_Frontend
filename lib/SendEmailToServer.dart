import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> sendPostRequest(String email) async {
  const String apiUrl = 'http://192.168.137.216:8080/userAuth';
  var userEmail = jsonEncode({'email': email}); // Сериализация body в формат JSON

  http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: userEmail,
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    int userId = jsonResponse['userId'];
    print('UserId: $userId');
    return userId;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception(
        'Failed to fetch user ID'); // Добавлено исключение в случае ошибки
  }
}
