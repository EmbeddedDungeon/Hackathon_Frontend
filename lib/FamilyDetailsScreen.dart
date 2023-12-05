import 'package:flutter/material.dart';
import 'AddFicheScreen.dart';
import 'FicheScreen.dart';
import 'assets/dto/EachFamilyDto.dart';
import 'package:http/http.dart' as http;

class FamilyDetailsScreen extends StatefulWidget {
  final int campagneId;
  final int groupId;
  final String animalName;

  FamilyDetailsScreen({
    required this.campagneId,
    required this.groupId,
    required this.animalName,
  });

  @override
  _FamilyDetailsScreenState createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  EachFamilyDto? _familyDetails;

  @override
  void initState() {
    super.initState();
    _fetchFamilyDetails(); // Вызываем метод загрузки деталей семьи при инициализации виджета
  }

  Future<void> _fetchFamilyDetails() async {
    // // Hardcoded response for simulation
    // final response = '''
    //   {
    //     "campagneId": 1,
    //     "count": 4,
    //     "groupeId": 1,
    //     "animalName": "Frog",
    //     "fichesIds": [1, 5, 15, 77]
    //   }
    // ''';
    //
    // setState(() {
    //   _familyDetails = EachFamilyDto.fromJson(response);
    // });

    // // Uncomment the following section for actual API call
    // final url = Uri.parse('http://192.168.137.216:8080/campagne/groupe/animal');
    // final response = await http.get(
    //   url,
    //   headers: {
    //     'campagneId': widget.campagneId.toString(),
    //     'groupId': widget.groupId.toString(),
    //     'animalName': widget.animalName,
    //   },
    // );
    final url = Uri.parse(
        'http://192.168.137.216:8080/campagne/groupe/animal/' +
            widget.animalName.toLowerCase());
    final response = await http.get(
      url,
      headers: {
        'campagneId': widget.campagneId.toString(),
        'groupId': widget.groupId.toString(),
        'animalName': Uri.encodeComponent(widget.animalName),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _familyDetails = EachFamilyDto.fromJson(response.body);
      });
    } else {
      print("GET each family error");
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("${_familyDetails?.animalName ?? 'Family'} Family"),
  //       backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
  //     ),
  //     body: _familyDetails == null
  //         ? Center(
  //       child: CircularProgressIndicator(), // Show a loading indicator
  //     )
  //         : Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             "Animal Species",
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: _familyDetails!.fichesIds.length,
  //             itemBuilder: (context, index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => FicheScreen(ficheId: _familyDetails!.fichesIds[index]),
  //                     ),
  //                   );
  //                 },
  //                 child: ListTile(
  //                   title: Text("Species ${_familyDetails!.fichesIds[index]}"),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         ElevatedButton(
  //           onPressed: () {
  //             _showAddElementNotification(context);
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => AddFiche(),
  //               ),
  //             );
  //           },
  //           child: Icon(Icons.add), // + button
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_familyDetails?.animalName ?? 'Family'} Family"),
        backgroundColor: Color.fromRGBO(123, 185, 255, 1.0),
      ),
      body: _familyDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Animal Species",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _familyDetails!.fichesIds.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                                "Species ${_familyDetails!.fichesIds[index]}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FicheScreen(
                                    ficheId: _familyDetails!.fichesIds[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showAddElementNotification(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFiche(),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 240, 213, 1.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _showAddElementNotification(BuildContext context) {
    // Add logic to show a notification for adding a new element
    // You can use the Flutter toast or any other package for notifications
    // Example using Flutter toast package:
    // showToast("Add Element Notification", context: context);
  }
}
