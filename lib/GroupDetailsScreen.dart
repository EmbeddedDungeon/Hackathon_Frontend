import 'package:flutter/material.dart';
import 'FamilyDetailsScreen.dart';
import 'assets/dto/EachGroupDto.dart';
import 'AddFicheScreen.dart';
import 'package:http/http.dart' as http;

import 'assets/dto/GlobalVariables.dart';

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
    _fetchGroupDetails();
  }

  Future<void> _fetchGroupDetails() async {
    // // Hardcoded response for simulation
    // final response = '''
    //   {
    //     "campagneId": 1,
    //     "groupeId": 1,
    //     "groupeName": "Amphibiens",
    //     "animalNames": ["Frog", "Crapaud", "Gueko", "Salamandre"]
    //   }
    // ''';
    //
    // setState(() {
    //   _groupDetails = EachGroupDto.fromJson(response);
    // });

    // Uncomment the following section for actual API call
    final url = Uri.parse('http://192.168.137.216:8080/campagne/groupe');
    final response = await http.get(
      url,
      headers: {'campagneId': widget.campagneId.toString(), 'groupId': widget.groupId.toString()},
    );
    if (response.statusCode == 200) {
      setState(() {
        _groupDetails = EachGroupDto.fromJson(response.body);
      });
    } else {
      print("GET each group error");
    }

    GroupManager groupManager = GroupManager();
    groupManager.setGroupId(_groupDetails!.groupeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groupe : ${_groupDetails?.groupeName}"),
        backgroundColor: Color.fromRGBO(237, 243, 255, 1.0),
      ),
      body: _groupDetails == null
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
                "Familles d'animaux",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _groupDetails!.animalNames.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      color: Color.fromRGBO(252, 252, 252, 1),
                      child: ListTile(
                        title: Text(_groupDetails!.animalNames[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FamilyDetailsScreen(
                                campagneId: _groupDetails!.campagneId,
                                groupId: _groupDetails!.groupeId,
                                animalName: _groupDetails!.animalNames[index],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFiche(),
                      ),
                    );
                  },
                  child: Text("Ajouter une fiche d'animal", style: TextStyle(color: Colors.black)),
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
    );
  }



}
