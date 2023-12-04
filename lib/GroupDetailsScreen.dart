import 'package:flutter/material.dart';
import 'FamilyDetailsScreen.dart';
//
// class GroupDetailsScreen extends StatelessWidget {
//   final String animalGroup;
//
//   GroupDetailsScreen({required this.animalGroup});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("$animalGroup Group"),
//         backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Animal family",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 // List of animal types for the selected category
//                 ListTile(
//                   title: Text("Felidae"), // Example: Cats family
//                   onTap: () {
//                     // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
//                     _navigateToAnimalSubspeciesScreen(context, "Felidae");
//                   },
//                 ),
//                 ListTile(
//                   title: Text("Canidae"), // Example: Dogs family
//                   onTap: () {
//                     // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
//                     _navigateToAnimalSubspeciesScreen(context, "Canidae");
//                   },
//                 ),
//                 ListTile(
//                   title: Text("Mustelidae"), // Example: Weasels family
//                   onTap: () {
//                     // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
//                     _navigateToAnimalSubspeciesScreen(context, "Mustelidae");
//                   },
//                 ),
//                 // Add more animal types as needed
//
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _navigateToAnimalSubspeciesScreen(BuildContext context, String animalFamily) {
//     // Navigate to the screen with animal subspecies
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FamilyDetailsScreen(animalFamily: animalFamily),
//       ),
//     );
//   }
//
//
// }


import 'assets/dto/EachGroupDto.dart';

class GroupDetailsScreen extends StatefulWidget {
  final int campagneId;
  final int groupId;

  GroupDetailsScreen({required this.campagneId, required this.groupId});

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  EachGroupDto? _groupDetails;

  @override
  void initState() {
    super.initState();
    _fetchGroupDetails(); // Вызываем метод загрузки деталей группы при инициализации виджета
  }

  Future<void> _fetchGroupDetails() async {
    // Hardcoded response for simulation
    final response = '''
      {
        "campagneId": 1,
        "groupeId": 1,
        "groupeName": "Amphibiens",
        "animalNames": ["Frog", "Crapaud", "Gueko", "Salamandre"]
      }
    ''';

    setState(() {
      _groupDetails = EachGroupDto.fromJson(response);
    });

    // Uncomment the following section for actual API call
    // final url = Uri.parse('http://192.168.137.247:8080/campagne/group');
    // final response = await http.get(
    //   url,
    //   headers: {'campagneId': widget.campagneId.toString(), 'groupId': widget.groupId.toString()},
    // );
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _groupDetails = EachGroupDto.fromJson(response.body);
    //   });
    // } else {
    //   // Handle error response
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_groupDetails?.groupeName ?? 'Group'} Group"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: _groupDetails == null
          ? Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Animal family",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _groupDetails!.animalNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_groupDetails!.animalNames[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FamilyDetailsScreen(
                          animalFamily: _groupDetails!.animalNames[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
