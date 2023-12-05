import 'package:flutter/material.dart';
import 'assets/dto/FicheDto.dart';
import 'package:http/http.dart' as http;

class FicheScreen extends StatefulWidget {
  final int ficheId;

  FicheScreen({required this.ficheId});

  @override
  _FicheScreenState createState() => _FicheScreenState();
}

class _FicheScreenState extends State<FicheScreen> {
  FicheDto? _ficheDetails;

  @override
  void initState() {
    super.initState();
    _fetchFicheDetails(); // Вызываем метод загрузки деталей фише при инициализации виджета
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
      });
    } else {
      // Handle error response
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
                          ],
                        ),
                      ),
                      SizedBox(
                        // Comments list with scrollbar
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView(
                          shrinkWrap: true,
                          children:
                              _ficheDetails!.commentaires.map((commentaire) {
                            return ListTile(
                              title: Text(
                                "${commentaire.userName} ${commentaire.userSurname}: ${commentaire.description}",
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Добавьте пустое пространство после комментариев, если нужно
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
