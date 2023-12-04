// FamilyDetailsScreen.dart
import 'package:flutter/material.dart';
import 'AddFicheScreen.dart';
import 'FicheScreen.dart';

class FamilyDetailsScreen extends StatelessWidget {
  final String animalFamily;

  FamilyDetailsScreen({required this.animalFamily});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$animalFamily Family"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Animal Species:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // ListTile with a GestureDetector to navigate to FicheScreen
                GestureDetector(
                  onTap: () {
                    // Navigate to FicheScreen when the list item is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FicheScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text("Species 1"),
                  ),
                ),
                // Add more ListTiles with GestureDetector for other species

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print("Hi there, add me (to AddFiche)!");
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
