import 'package:flutter/material.dart';
import 'AddCampaignScreen.dart';
import 'CampaignDetailsScreen.dart';
import 'assets/dto/CampaignDto.dart';

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
    // // COMMENT
    // final response = '''
    //   {
    //     "campagnes" : [
    //       { "campagneId" : 1, "campagneName" : "Great campaign" },
    //       { "campagneId" : 2, "campagneName" : "Insane campaign" }
    //     ]
    //   }
    // ''';
    // setState(() {
    //   _campaigns = CampaignListFactory.parseCampaignList(response);
    // });
    // // ...

    // UNCOMMENT
    final response = await http
        .get(Uri.parse('http://192.168.137.216:8080/campagnes')); // CHANGE!
    if (response.statusCode == 200) {
      setState(() {
        _campaigns = CampaignListFactory.parseCampaignList(response.body);
      });
    } else {
      print("GET list of campaigns error");
    }
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Campagnes"),
        backgroundColor: Color.fromRGBO(237, 243, 255, 1.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _campaigns.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 3,
                color: Color.fromRGBO(252, 252, 252, 1),
                child: ListTile(
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
                        builder: (context) =>
                            CampaignDetailsScreen(_campaigns[index].campagneId),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddElementNotification(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCampaign(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 249, 236, 1.0),
      ),
    );
  }


  void _showAddElementNotification(BuildContext context) {
    // Implement notification logic
  }
}
