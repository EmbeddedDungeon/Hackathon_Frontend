import 'package:flutter/material.dart';

//
// class AddFicheScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Fiche'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Add Information for New Fiche',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Enter Animal Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Enter Date',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Add logic to save the fiche information
//                 // For example, save data to database or perform necessary actions
//                 // You can add your logic here
//                 // Once done, you might want to navigate back to the previous screen
//                 Navigator.pop(context); // Close the AddFicheScreen
//               },
//               child: Text('Save Fiche'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddFiche extends StatefulWidget {
  @override
  _AddFicheState createState() => _AddFicheState();
}

class _AddFicheState extends State<AddFiche> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String animalName = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // TODO: Добавьте логику для получения координат GPS

  // TODO: Добавьте логику для получения местоположения через API Geocoder

  // TODO: Добавьте логику для добавления фотографий

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Fiche'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    animalName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter animal name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Date'),
              ),
              SizedBox(height: 10),
              Text(
                'Selected Date: ${selectedDate.toString()}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time'),
              ),
              SizedBox(height: 10),
              Text(
                'Selected Time: ${selectedTime.format(context)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to save the fiche information
                  // For example, save data to database or perform necessary actions
                  // You can add your logic here
                  // Once done, you might want to navigate back to the previous screen
                  Navigator.pop(context); // Close the AddFicheScreen
                },
                child: Text('Save Fiche'),
              ),
              // TODO: Добавьте элементы для загрузки фотографий и записи наблюдений
            ],
          ),
        ),
      ),
    );
  }
}
