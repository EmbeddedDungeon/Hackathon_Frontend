import 'package:flutter/material.dart';
import 'assets/dto/FicheDto.dart';
import 'package:http/http.dart' as http;
import 'DownloadImage.dart';
import 'dart:typed_data';


class FicheScreen extends StatefulWidget {
  final int ficheId;
  FicheScreen({required this.ficheId});

  @override
  _FicheScreenState createState() => _FicheScreenState();
}

class _FicheScreenState extends State<FicheScreen> {
  FicheDto? _ficheDetails;
  List<int>? _imageData;

  @override
  void initState() {
    super.initState();
    _fetchFicheDetails(); // Вызываем метод загрузки деталей фише при инициализации виджета
    loadImage();
  }

  Future<void> _fetchFicheDetails() async {
  //   // // Hardcoded response for simulation
  //
  //   final response = '''
  //   {
  //     "ficheId": 5,
  //   "description": "Fiche1",
  //   "familyName": "ARAIGNÉE",
  //   "time": {
  //   "hour": 8,
  //   "minute": 38,
  //   "second": 0
  // },
  //   "date": {
  //   "day": 13,
  //   "month": 1,
  //   "year": 2023
  // },
  //   "coordX": -1.2,
  //   "coordY": 5.8,
  //        "commentaires": [
  //          { "commentaireId": 1, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "superbe trouvaille !" },
  //          { "commentaireId": 2, "userId": 2, "userName": "Pierre", "userSurname": "Peret", "description": "Cela me donne faim" },
  //          { "commentaireId": 3, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "Je vais te faire un procès" },
  //          { "commentaireId": 3, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "Je vais te faire un procès" },
  //          { "commentaireId": 3, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "Je vais te faire un procès" }
  //        ]
  // }
  // ''';
  //
  //   setState(() {
  //     _ficheDetails = FicheDto.fromJson(response);
  //   });

    // Uncomment the following section for actual API call
    final url = Uri.parse('http://192.168.137.216:8080/fiche');
    final response = await http.get(url, headers: {'ficheId': widget.ficheId.toString()});
    if (response.statusCode == 200) {
      setState(() {
        _ficheDetails = FicheDto.fromJson(response.body);
        print("campagneId = = = " + _ficheDetails!.campagneId.toString());
      });
    } else {
      // Handle error response
    }
  }

  Future<void> loadImage() async {
    DownloadImage imageFetcher = DownloadImage();
    try {
      List<int> imageData = await imageFetcher.fetchImageByNumber(123); // Номер изображения
      setState(() {
        _imageData = imageData;
      });
    } catch (e) {
      print('Failed to load image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Type d'animal : ${_ficheDetails?.familyName}"),
      ),
      body: _ficheDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${_ficheDetails!.description}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // Date
                        "${_ficheDetails!.date['day']}/${_ficheDetails!.date['month']}/${_ficheDetails!.date['year']}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      if (_ficheDetails!.coordX != null &&
                          _ficheDetails!.coordY != null)
                        SizedBox(height: 10),
                      Text(
                        // Coordinates
                        "Coordonnées",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // Coordinates
                        "${_ficheDetails!.coordX}, ${_ficheDetails!.coordY}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        // Comments
                        "Commentaires",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        // Comments list with scrollbar
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _ficheDetails!.commentaires.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              color: Color.fromRGBO(252, 252, 252, 1),
                              child: ListTile(
                                title: Text(
                                  "${_ficheDetails!.commentaires[index].userName} ${_ficheDetails!.commentaires[index].userSurname}: ${_ficheDetails!.commentaires[index].description}",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (_imageData != null) // Проверяем, есть ли данные об изображении
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              // Image Title
                              "just look at this animal. It's very cute.",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 200, // Установите желаемую высоту изображения
                              child: Image.memory(
                                Uint8List.fromList(_imageData!), // Преобразование List<int> в Uint8List
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
