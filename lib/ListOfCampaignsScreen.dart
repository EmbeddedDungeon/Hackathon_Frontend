import 'package:flutter/material.dart';
import 'AddCampaignScreen.dart';
import 'CampaignDetailsScreen.dart';

import 'assets/dto/CampaignDto.dart';

// class ListOfCompaignsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("List of Companies"),
//         backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             title: Text("Company 1"),
//             trailing: IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 // Add logic to delete the company
//               },
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CompaignParametersScreen(),
//                 ),
//               );
//             },
//           ),
//
//           SizedBox(height: 20),
//
//           ElevatedButton(
//             onPressed: () {
//               _showAddElementNotification(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddCampaignScreen(), // Переход к экрану AddCampaign при нажатии кнопки "Add"
//                 ),
//               );
//             },
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAddElementNotification(BuildContext context) {
//
//   }
// }
//
//

import 'package:http/http.dart' as http;

class ListOfCompaignsScreen extends StatefulWidget {
  @override
  _ListOfCompaignsScreenState createState() => _ListOfCompaignsScreenState();
}

class _ListOfCompaignsScreenState extends State<ListOfCompaignsScreen> {
  List<CampaignDto> _campaigns = [];

  @override
  void initState() {
    super.initState();
    _fetchCampaigns(); // Вызываем метод загрузки кампаний при инициализации виджета
  }

  Future<void> _fetchCampaigns() async {
    // COMMENT
    final response = '''
      { 
        "campagnes" : [ 
          { "campagneId" : 1, "campagneName" : "Great campaign" }, 
          { "campagneId" : 2, "campagneName" : "Insane campaign" } 
        ] 
      }
    ''';
    setState(() {
      _campaigns = CampaignListFactory.parseCampaignList(response);
    });
    // ...

    // UNCOMMENT
    // final response = await http.get(Uri.parse('http://192.168.137.247:8080/campagnes')); // CHANGE!
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _campaigns = CampaignListFactory.parseCampaignList(response.body);
    //   });
    // } else {
    //   // Обработка ошибки запроса
    // }
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Companies"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: ListView.builder(
        itemCount: _campaigns.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_campaigns[index].campagneName),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // Add logic to delete the company
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CampaignDetailsScreen(_campaigns[index].campagneId),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddElementNotification(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCampaignScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddElementNotification(BuildContext context) {
    // Implement notification logic
  }
}
