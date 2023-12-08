import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotDTOparam {
  final int ficheId;
  final int id;
  final String fileName;

  PhotDTOparam({
    required this.ficheId,
    required this.id,
    required this.fileName,
  });

  factory PhotDTOparam.fromJson(Map<String, dynamic> json) {
    return PhotDTOparam(
      ficheId: json['ficheId'] as int,
      id: json['id'] as int,
      fileName: json['fileName'] as String,
    );
  }

  static Future<List<PhotDTOparam>> fetchData(int ficheId) async {
    String url = 'http://192.168.137.216:8080/fiche/photos';
    Map<String, String> headers = {
      'ficheId': ficheId.toString(),
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print("photo get 200 code");
        List<dynamic> photoJsonList = json.decode(response.body);
        print("List of photo ids");
        print(photoJsonList);

        if (photoJsonList.isEmpty) {
          print('The photo list is empty');
          return [];
        } else {
          List<PhotDTOparam> photoList =
          photoJsonList.map((json) => PhotDTOparam.fromJson(json)).toList();
          return photoList;
        }
      } else {
        print('Error during data retrieval: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

// Ваш другой класс, где вы хотите использовать fetchData из PhotDTOparam
class AnotherClass {
  void useFetchData() async {
    int exampleFicheId = 5;
    List<PhotDTOparam> fetchedPhotos = await PhotDTOparam.fetchData(exampleFicheId);

    // Используйте fetchedPhotos здесь
    // Например, вы можете распечатать информацию о полученных фотографиях
    print('Received photos:');
    for (var photo in fetchedPhotos) {
      print('ficheId: ${photo.ficheId}, id: ${photo.id}, fileName: ${photo.fileName}');
    }
  }
}
