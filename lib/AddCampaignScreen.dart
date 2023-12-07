import 'dart:convert';

import 'package:atlas_of_biodiversity/ListOfCampaignsScreen.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'GroupDetailsScreen.dart';
import 'LocationPickerScreen.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http; // Добавляем импорт для работы с HTTP
import 'ImageUploader.dart';
import 'assets/dto/CampaignPostDto.dart';
import 'assets/dto/GlobalVariables.dart';

// Преобразование числа в массив байтов (Uint8List)
extension IntToBytes on int {
  Uint8List toBytes() {
    var byteData = Uint8List(4);
    var buffer = ByteData.view(byteData.buffer);
    buffer.setInt32(0, this, Endian.big);
    return byteData;
  }
}

class AddCampaign extends StatefulWidget {
  @override
  _AddCampaignState createState() => _AddCampaignState();
}

class _AddCampaignState extends State<AddCampaign> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String animalName = '';
  LatLng? selectedLocation;
  List<XFile> images = [];
  CampaignPostDto?  _campaignPostData;

  @override
  void initState() {
    DateTime now = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();

    super.initState();
    _campaignPostData = CampaignPostDto(
      id: 1,
      chefDeFileId: 1,
      description: 'une campagne fictive',
      titre: 'Campagne Title',
      heureDebut: {
        'hour': 16,
        'minute': 55,
        'second': 0,
      },
      heureFin: {
        'hour': 22,
        'minute': 10,
        'second': 0,
      },
      dateDebut: {
        'day': 1,
        'month': 1,
        'year': 2023,
      },
      dateFin: {
        'day': 4,
        'month': 12,
        'year': 2023,
      },
    );
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

    // if (picked != null && picked != selectedDate) {
    //   setState(() {
    //     selectedDate = picked;
    //     _campaignPostData?.date = {
    //       'day': picked.day,
    //       'month': picked.month,
    //       'year': picked.year,
    //     };
    //   });
    // }
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


  Future<void> _saveCampaign() async {
    const String apiUrl = 'http://192.168.137.216:8080/campagne';

    String campaignJson = jsonEncode(_campaignPostData);

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: campaignJson,
      );

      print("POST /campagne " + campaignJson);

      if (response.statusCode == 200) {
        print('Campaign успешно сохранен!');
        // Дополнительные действия после успешного сохранения, если нужно
      } else {
        print('Ошибка сохранения Campaign: ${response.statusCode}');
        // Обработка ошибки сохранения
      }
    } catch (e) {
      print('Ошибка при отправке запроса: $e');
      // Обработка ошибки при отправке запроса
    }

    // Закрытие экрана AddCampaign
    // Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListOfCompaignsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Campaign'),
        backgroundColor: Color.fromRGBO(237, 243, 255, 1.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 3,
                color: Color.fromRGBO(252, 252, 252, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      _campaignPostData?.titre = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Titre de la campagne',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      border: InputBorder.none, // Remove the border
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                color: Color.fromRGBO(252, 252, 252, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      _campaignPostData?.description = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      border: InputBorder.none, // Remove the border
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: _saveCampaign,
                    child: Text('Enregistrer', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 249, 236, 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
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
