import 'package:flutter/material.dart';
import 'FamilyDetailsScreen.dart';
import 'assets/dto/EachGroupDto.dart';
import 'package:http/http.dart' as http;

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
  }

  // Old style
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("${_groupDetails?.groupeName ?? 'Group'} Group"),
  //       backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
  //     ),
  //     body: _groupDetails == null
  //         ? Center(
  //       child: CircularProgressIndicator(), // Show a loading indicator
  //     )
  //         : Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             "Animal family",
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: _groupDetails!.animalNames.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 title: Text(_groupDetails!.animalNames[index]),
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => FamilyDetailsScreen(
  //                         campagneId: _groupDetails!.campagneId,
  //                         groupId: _groupDetails!.groupeId,
  //                         animalName: _groupDetails!.animalNames[index],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_groupDetails?.groupeName ?? 'Group'} Group"),
        backgroundColor: Color.fromRGBO(123, 185, 255, 1.0),
      ),
      body: _groupDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Animal family",
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
          ],
        ),
      ),
    );
  }


}
