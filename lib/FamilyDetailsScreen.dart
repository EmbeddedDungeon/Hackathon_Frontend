// // FamilyDetailsScreen.dart
// import 'package:flutter/material.dart';
// import 'AddFicheScreen.dart';
// import 'FicheScreen.dart';
//
// class FamilyDetailsScreen extends StatelessWidget {
//   final String animalFamily;
//
//   FamilyDetailsScreen({required this.animalFamily});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("$animalFamily Family"),
//         backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Animal Species:",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 // ListTile with a GestureDetector to navigate to FicheScreen
//                 GestureDetector(
//                   onTap: () {
//                     // Navigate to FicheScreen when the list item is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => FicheScreen()),
//                     );
//                   },
//                   child: ListTile(
//                     title: Text("Species 1"),
//                   ),
//                 ),
//                 // Add more ListTiles with GestureDetector for other species
//
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     print("Hi there, add me (to AddFiche)!");
//                     _showAddElementNotification(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddFiche(),
//                       ),
//                     );
//                   },
//                   child: Icon(Icons.add), // + button
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAddElementNotification(BuildContext context) {
//     // Add logic to show a notification for adding a new element
//     // You can use the Flutter toast or any other package for notifications
//     // Example using Flutter toast package:
//     // showToast("Add Element Notification", context: context);
//   }
// }


import 'package:flutter/material.dart';
import 'AddFicheScreen.dart';
import 'FicheScreen.dart';
import 'assets/dto/EachFamilyDto.dart';

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
    // Hardcoded response for simulation
    final response = '''
      {
        "campagneId": 1,
        "count": 4,
        "groupeId": 1,
        "animalName": "Frog",
        "fichesIds": [1, 5, 15, 77]
      }
    ''';

    setState(() {
      _familyDetails = EachFamilyDto.fromJson(response);
    });

    // Uncomment the following section for actual API call
    // final url = Uri.parse('http://192.168.137.247:8080/campagne/group/animal');
    // final response = await http.get(
    //   url,
    //   headers: {
    //     'campagneId': widget.campagneId.toString(),
    //     'groupId': widget.groupId.toString(),
    //     'animalName': widget.animalName,
    //   },
    // );
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _familyDetails = EachFamilyDto.fromJson(response.body);
    //   });
    // } else {
    //   // Handle error response
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_familyDetails?.animalName ?? 'Family'} Family"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: _familyDetails == null
          ? Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Animal Species",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _familyDetails!.fichesIds.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FicheScreen(ficheId: _familyDetails!.fichesIds[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text("Species ${_familyDetails!.fichesIds[index]}"),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showAddElementNotification(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFiche(),
                ),
              );
            },
            child: Icon(Icons.add), // + button
          ),
        ],
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
