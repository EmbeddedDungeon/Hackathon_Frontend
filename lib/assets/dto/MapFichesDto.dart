import 'dart:convert';
import 'package:http/http.dart' as http;

class CoordDto {
  final int ficheId;
  final double coordX;
  final double coordY;

  CoordDto({
    required this.ficheId,
    required this.coordX,
    required this.coordY,
  });

  factory CoordDto.fromJson(Map<String, dynamic> json) {
    return CoordDto(
      ficheId: json['ficheId'],
      coordX: json['coordX'],
      coordY: json['coordY'],
    );
  }
}

class FichesCoordsFetcher {
  static Future<List<CoordDto>?> fetchFichesCoords(int campagneId) async {
    final url = Uri.parse('http://192.168.137.216:8080/campagne/coord');

    Map<String, String> headers = {
      'headerParam': campagneId.toString(),
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // Добавленный принт

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<Map<String, dynamic>> coordListJson = jsonResponse['coordList'];

        print('CoordList JSON: $coordListJson'); // Добавленный принт

        List<CoordDto> coordList = coordListJson.map((json) => CoordDto.fromJson(json)).toList();
        return coordList;
      } else {
        print('Failed with status code: ${response.statusCode}'); // Добавленный принт
        return null;
      }
    } catch (e) {
      print('Exception: $e'); // Добавленный принт
      return null;
    }
  }
}


// Где-то в другом месте кода:

void fetchData(int campagneId) async {
  int campagneId = 1; // Идентификатор кампании, для которой нужно получить координаты

  List<CoordDto>? fetchedCoords = await FichesCoordsFetcher.fetchFichesCoords(campagneId);

  if (fetchedCoords != null) {
    // Делаем что-то с полученным списком координат
    fetchedCoords.forEach((coord) {
      print('Fiche ID: ${coord.ficheId}, CoordX: ${coord.coordX}, CoordY: ${coord.coordY}');
      // Можно выполнять другие операции с координатами
    });
  } else {
    // Обработка ошибки при получении координат
    print('Failed to fetch coordinates');
  }
}
