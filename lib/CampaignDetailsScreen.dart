import 'dart:convert';

import 'package:flutter/material.dart';
import 'GroupDetailsScreen.dart';
import 'MapScreen.dart';
import 'assets/dto/EachCampaignDto.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final int campagneId;

  CampaignDetailsScreen(this.campagneId);

  @override
  _CampaignDetailsScreenState createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  EachCampaignDto? _campaignDetails;

  @override
  void initState() {
    super.initState();
    _fetchCampaignDetails(); // Вызываем метод загрузки деталей кампании при инициализации виджета
  }

  Future<void> _fetchCampaignDetails() async {
    // Hardcoded response for simulation
    final response = '''
      {
        "campagneId": 1,
        "name": "Campagne1",
        "description": "Une campagne bénévole..",
        "groupes": [
          {"id": 1, "nom": "Amphibiens"},
          {"id": 2, "nom": "Reptiles"}
        ],
        "communes": [
          {"id": 1, "nom": "Cesson-Sevigné"},
          {"id": 2, "nom": "Roubaix"}
        ]
      }
    ''';

    setState(() {
      _campaignDetails = EachCampaignDto.fromJson(response);
    });

    // Uncomment the following section for actual API call
    // final url = Uri.parse('http://192.168.137.247:8080/campagne');
    // final response = await http.get(url, headers: {'campagneId': widget.campagneId.toString()});
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _campaignDetails = EachCampaignDto.fromJson(response.body);
    //   });
    // } else {
    //   // Handle error response
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaigne Details"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: _campaignDetails == null
          ? Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${_campaignDetails!.name}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Description: ${_campaignDetails!.description}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Groups",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _campaignDetails!.groupes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_campaignDetails!.groupes[index].nom),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupDetailsScreen(
                                  campagneId: _campaignDetails!.campagneId,
                                  groupId: _campaignDetails!.groupes[index].id,
                                ),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _campaignDetails!.groupes.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _campaignDetails!.groupes
                              .add(Groupes(id: 3, nom: "New Group")); // CHANGE
                        });
                      },
                      child: Text("Add group"),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Communes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _campaignDetails!.communes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_campaignDetails!.communes[index].nom),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _campaignDetails!.communes.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _campaignDetails!.communes
                              .add(Communes(id: 3, nom: "New Commune"));
                        });
                      },
                      child: Text("Add commune"),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
