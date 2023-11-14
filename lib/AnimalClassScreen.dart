import 'package:flutter/material.dart';
import 'AnimalFamilyScreen.dart';

class AnimalClassScreen extends StatelessWidget {
  final String animalClass;

  AnimalClassScreen({required this.animalClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$animalClass Class"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Animal Family:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // List of animal types for the selected category
                ListTile(
                  title: Text("Felidae"), // Example: Cats family
                  onTap: () {
                    // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
                    _navigateToAnimalSubspeciesScreen(context, "Felidae");
                  },
                ),
                ListTile(
                  title: Text("Canidae"), // Example: Dogs family
                  onTap: () {
                    // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
                    _navigateToAnimalSubspeciesScreen(context, "Canidae");
                  },
                ),
                ListTile(
                  title: Text("Mustelidae"), // Example: Weasels family
                  onTap: () {
                    // Navigate to the AnimalSubspeciesScreen with the selected animal type and category
                    _navigateToAnimalSubspeciesScreen(context, "Mustelidae");
                  },
                ),
                // Add more animal types as needed

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAnimalSubspeciesScreen(BuildContext context, String animalFamily) {
    // Navigate to the screen with animal subspecies
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalFamilyScreen(animalFamily: animalFamily),
      ),
    );
  }


}
