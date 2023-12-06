import 'dart:convert';

import 'package:flutter/material.dart';
import 'GroupDetailsScreen.dart';
import 'MapScreen.dart';
import 'assets/dto/EachCampaignDto.dart';
import 'package:http/http.dart' as http;

import 'assets/dto/GlobalVariables.dart';

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
    // // Hardcoded response for simulation
    // final response = '''
    //   {
    //     "campagneId": 1,
    //     "name": "Campagne1",
    //     "description": "Une campagne bénévole..",
    //     "groupes": [
    //       {"id": 1, "nom": "Amphibiens"},
    //       {"id": 2, "nom": "Reptiles"}
    //     ],
    //     "communes": [
    //       {"id": 1, "nom": "Cesson-Sevigné"},
    //       {"id": 2, "nom": "Roubaix"}
    //     ]
    //   }
    // ''';
    // setState(() {
    //   _campaignDetails = EachCampaignDto.fromJson(response);
    // });

    // Uncomment the following section for actual API call
    final url = Uri.parse('http://192.168.137.216:8080/campagne');
    final response = await http.get(
        url, headers: {'campagneId': widget.campagneId.toString()});
    if (response.statusCode == 200) {
      setState(() {
        _campaignDetails = EachCampaignDto.fromJson(response.body);
      });
    } else {
      print("GET each campaign error");
    }

    CampagneManager campagneManager = CampagneManager();
    campagneManager.setCampagneId(_campaignDetails!.campagneId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campagne : ${_campaignDetails?.name}"),
        backgroundColor: Color.fromRGBO(237, 243, 255, 1.0),
      ),
      body: _campaignDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_campaignDetails!.description}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Groupes d'animaux",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _campaignDetails!.groupes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      color: Color.fromRGBO(252, 252, 252, 1),
                      child: ListTile(
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
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _campaignDetails!.groupes.add(Groupes(id: 3, nom: "Le nouveau groupe"));
                    });
                  },
                  child: Text("Ajouter un groupe", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 249, 236, 1.0),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Communes de la campagne",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _campaignDetails!.communes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        dense: true,
                        title: Text(_campaignDetails!.communes[index].nom),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _campaignDetails!.communes.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _campaignDetails!.communes.add(Communes(id: 3, nom: "La nouvelle commune"));
                    });
                  },
                  child: Text("Ajouter une commune", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 249, 236, 1.0),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
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



