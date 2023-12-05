import 'package:flutter/material.dart';
import 'assets/dto/FicheDto.dart';

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
    // Hardcoded response for simulation
    final response = '''
      {
        "campagneId": 1,
        "ficheId": 1,
        "description": "j'ai trouvé cette grenouille en me promenant de bon matin",
        "time": { "hour": 16, "minute": 55, "second": 0 },
        "date": { "year": 2023, "month": 1, "day": 12 },
        "commentaires": [
          { "commentaireId": 1, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "superbe trouvaille !" },
          { "commentaireId": 2, "userId": 2, "userName": "Pierre", "userSurname": "Peret", "description": "Cela me donne faim" },
          { "commentaireId": 3, "userId": 1, "userName": "Jean", "userSurname": "Macé", "description": "Je vais te faire un procès" }
        ]
      }
    ''';

    setState(() {
      _ficheDetails = FicheDto.fromJson(response);
    });

    // Uncomment the following section for actual API call
    // final url = Uri.parse('http://192.168.137.247:8080/fiche');
    // final response = await http.get(url, headers: {'ficheId': widget.ficheId.toString()});
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _ficheDetails = FicheDto.fromJson(response.body);
    //   });
    // } else {
    //   // Handle error response
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_ficheDetails?.ficheId ?? 'Species'}"),
      ),
      body: _ficheDetails == null
          ? Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${_ficheDetails!.description}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Date: ${_ficheDetails!.date['day']}/${_ficheDetails!.date['month']}/${_ficheDetails!.date['year']}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Commentaires:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _ficheDetails!.commentaires.map((commentaire) {
                return ListTile(
                  title: Text("${commentaire.userName} ${commentaire.userSurname}: ${commentaire.description}"),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

