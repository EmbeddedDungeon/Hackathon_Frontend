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

  void printDetails() {
    print('Fiche ID: $ficheId, Coordinates: ($coordX, $coordY)');
  }
}


class FichesCoordsFetcher {
  static Future<List<CoordDto>?> fetchFichesCoords(int campagneId) async {
    final url = Uri.parse('http://192.168.137.216:8080/campagne/coord');
    Map<String, String> headers = {
      'campagneId': campagneId.toString(),
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic> coordListJson = jsonResponse['coordList'];
        List<CoordDto> coordList = coordListJson.map((json) => CoordDto.fromJson(json as Map<String, dynamic>)).toList();
        for (CoordDto coord in coordList) {
          coord.printDetails();
        }
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
