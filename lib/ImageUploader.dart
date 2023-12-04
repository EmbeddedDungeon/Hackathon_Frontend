import 'package:http/http.dart' as http;
import 'dart:io';

class ImageUploader {
  Future<bool> uploadImages(List<File> images) async {
    const String apiUrl = 'http://192.168.137.1:8080/upload'; // Укажите ваш адрес и порт

    try {
      for (var image in images) {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );

        var response = await request.send();
        if (response.statusCode != 200) {
          return false; // Если одна из загрузок не удалась, возвращаем false
        }
      }
      return true; // Если все изображения были успешно загружены
    } catch (e) {
      print('Error uploading images: $e');
      return false; // Если произошла ошибка при загрузке
    }
  }
}
