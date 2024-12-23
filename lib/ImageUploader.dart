import 'package:http/http.dart' as http;
import 'dart:io';

import 'assets/dto/GlobalVariables.dart';

class ImageUploader {
  Future<List<bool>> uploadImages(List<File> images) async {
    const String apiUrl = 'http://192.168.137.216:8080/images'; // Укажите ваш адрес и порт
    List<bool> uploadResults = [];
    final FicheManager ficheManager = FicheManager();

    try {
      int? ficheId = ficheManager.getFicheId();

      for (var image in images) {
        List<int> imageBytes = await image.readAsBytes();
        var response = await http.post(
          Uri.parse(apiUrl),
          body: imageBytes,
          headers: <String, String>{
            // 'Content-Type': 'image/png', // Укажите соответствующий Content-Type
            'ficheId': ficheId.toString(), // Добавляем ficheId в заголовок запроса
          },
        );

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          uploadResults.add(true); // Если изображение было успешно загружено
        } else {
          print('Here Failed to upload image: ${response.statusCode} ${response.body}');
          uploadResults.add(false); // Если загрузка изображения не удалась
        }
      }
    } catch (e) {
      print('Error uploading images: $e');
      // Добавьте в список результатов false для каждого изображения, если возникла ошибка при загрузке
      uploadResults.addAll(List.generate(images.length, (_) => false));
    }

    return uploadResults;
  }
}
