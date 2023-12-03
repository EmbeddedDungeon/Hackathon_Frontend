import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'LocationPickerScreen.dart';
class AddFiche extends StatefulWidget {
  @override
  _AddFicheState createState() => _AddFicheState();
}

class _AddFicheState extends State<AddFiche> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String animalName = '';
  LatLng? selectedLocation;
  List<XFile> images = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

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

  void _selectLocation() async {
    final location = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(),
      ),
    );

    if (location != null && location is LatLng) {
      setState(() {
        selectedLocation = location;
      });
    }
  }


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
                onPressed: _selectLocation,
                child: Text('Add Location'),
              ),
              SizedBox(height: 10),
              selectedLocation != null
                  ? Text(
                'Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}',
                style: TextStyle(fontSize: 16),
              )
                  : Container(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Add Photos'),
              ),
              SizedBox(height: 10),
              images.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: images.asMap().entries.map((entry) {
                  final index = entry.key;
                  final image = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Stack(
                      children: [
                        Image.file(
                          File(image.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
                  : Container(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save Fiche logic
                  Navigator.pop(context); // Close the AddFicheScreen
                },
                child: Text('Save Fiche'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


