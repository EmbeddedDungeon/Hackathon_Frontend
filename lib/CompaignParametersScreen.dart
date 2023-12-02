import 'package:flutter/material.dart';
import 'AnimalClassScreen.dart';
import 'MapScreen.dart'; // Импортируем файл MapScreen.dart

class CompaignParametersScreen extends StatelessWidget {
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
                      builder: (context) => MapScreen(), // Переход к MapScreen при нажатии кнопки "Map"
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
