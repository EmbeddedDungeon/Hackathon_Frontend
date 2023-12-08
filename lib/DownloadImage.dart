import 'dart:convert';
import 'package:http/http.dart' as http;

class DownloadImage {
  final String baseUrl = 'http://192.168.137.216:8080'; // Замените на ваш IP-адрес

  Future<List<int>> fetchImageByNumber(int imageNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/images/$imageNumber'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to upload image (fetchImageByNumber): ${response.statusCode}');
      throw Exception('Failed to upload image (fetchImageByNumber): ${response.statusCode}');
    }
  }
}