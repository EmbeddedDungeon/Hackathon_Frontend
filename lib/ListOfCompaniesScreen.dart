import 'package:flutter/material.dart';
import 'CompanyParametersScreen.dart';
class ListOfCompaniesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Companies"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text("Company 1"),
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
                  builder: (context) => CompanyParametersScreen(),
                ),
              );
            },
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              _showAddElementNotification(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddElementNotification(BuildContext context) {

  }
}


