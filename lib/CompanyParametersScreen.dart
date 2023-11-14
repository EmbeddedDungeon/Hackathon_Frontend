import 'package:flutter/material.dart';
import 'AnimalClassScreen.dart';

class CompanyParametersScreen extends StatelessWidget {
  // List of animal types
  final List<String> animalClass = ["Mammals", "Amphibians", "Reptiles", "Birds", "Fish"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Parameters:"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Animal Class",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: animalClass.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(animalClass[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimalClassScreen(animalClass: animalClass[index]),
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
