import 'package:flutter/material.dart';

class AnimalSubspeciesScreen extends StatelessWidget {
  final String animalFamily;

  AnimalSubspeciesScreen({required this.animalFamily});

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
                // List of animal subspecies for the selected type
                ListTile(
                  title: Text("Species 1"),
                  // Add more details as needed, e.g., images
                ),
                ListTile(
                  title: Text("Species 2"),
                  // Add more details as needed, e.g., images
                ),
                // Add more animal subspecies items as needed

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // Add logic to show the "Add Element" notification
                    _showAddElementNotification(context);
                  },
                  child: Icon(Icons.add),
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
