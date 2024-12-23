import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'GroupDetailsScreen.dart';
import 'LocationPickerScreen.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http; // Добавляем импорт для работы с HTTP
import 'ImageUploader.dart';
import 'assets/dto/FichePostDto.dart';
import 'assets/dto/GlobalVariables.dart';
import 'package:provider/provider.dart';

// class ImageUploader {
//   Future<bool> uploadImages(List<File> images) async {
//     const String serverAddress = '192.168.137.216';
//     const int serverPort = 8080;
//
//     try {
//       Socket socket = await Socket.connect(serverAddress, serverPort);
//
//       for (var imageFile in images) {
//         XFile xFile = XFile(imageFile.path);
//         File image = File(xFile.path);
//         Uint8List bytes = await image.readAsBytes();
//
//         // Отправка размера изображения
//         socket.add(bytes.lengthInBytes.toBytes());
//         // Отправка самих данных изображения
//         socket.add(bytes);
//       }
//
//       // Закрытие сокета после отправки всех изображений
//       socket.close();
//
//       return true; // Если все изображения были успешно отправлены
//     } catch (e) {
//       print('Error uploading images: $e');
//       return false; // Если произошла ошибка при отправке
//     }
//   }
// }

// Преобразование числа в массив байтов (Uint8List)
extension IntToBytes on int {
  Uint8List toBytes() {
    var byteData = Uint8List(4);
    var buffer = ByteData.view(byteData.buffer);
    buffer.setInt32(0, this, Endian.big);
    return byteData;
  }
}

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
  FichePostDto? _fichePostData;
  final FicheManager ficheManager = FicheManager();

  @override
  void initState() {
    DateTime now = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();

    UserManager userManager = UserManager();
    int userID = userManager.getUserId()!;

    super.initState();
    _fichePostData = FichePostDto(
      userId: userID,
      campagneId: 1,
      groupId: 1,
      description: "Default description",
      familyName: "Default family name",
      coordX: 5.25454,
      coordY: 6.21485,
      date: {
        'day': now.day,
        'month': now.month,
        'year': now.year,
      },
      time: {
        'hour': currentTime.hour,
        'minute': currentTime.minute,
        'second': 0,
      },
    );
  }

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

    // if (picked != null && picked != selectedDate) {
    //   setState(() {
    //     selectedDate = picked;
    //     _fichePostData?.date = {
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

  void _selectLocation() async {
    final location = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(),
      ),
    );

    if (location != null && location is LatLng) {
      setState(() {
        selectedLocation = location;
        _fichePostData?.coordX = selectedLocation?.latitude;
        _fichePostData?.coordY = selectedLocation?.longitude;
      });
    }
  }

  // Метод, который преобразует список XFile в список File
  List<File> convertXFilesToFiles(List<XFile> xFiles) {
    List<File> files = [];
    for (var xFile in xFiles) {
      File file = File(xFile.path);
      files.add(file);
    }
    return files;
  }

  Future<void> _saveFiche() async {
    const String apiUrl = 'http://192.168.137.216:8080/fiche';



    GroupManager groupManager = GroupManager();
    _fichePostData?.groupId = groupManager.getGroupId()!;
    CampagneManager campagneManager = CampagneManager();
    _fichePostData?.campagneId = campagneManager.getCampagneId()!;

    String ficheJson = jsonEncode(_fichePostData);

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: ficheJson,
      );

      print("POST /fiche " + ficheJson);

      if (response.statusCode == 200) {
        print('Fiche успешно сохранен!');
        int ficheId = json.decode(response.body);
        print('Fiche post json response: $ficheId'); // Посмотреть содержимое ответа сервера

        ficheManager.setFicheId(ficheId);
      } else {
        print('Ошибка сохранения Fiche: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при отправке запроса: $e');
      // Обработка ошибки при отправке запроса
    }
    ImageUploader uploader = ImageUploader();

    if (images.isNotEmpty) {
      // Преобразование списка XFile в список File
      List<File> files = convertXFilesToFiles(images);

      // Загрузка изображений на сервер с помощью ImageUploader
      await uploader.uploadImages(files);
    }
    // Закрытие экрана AddFiche
    // Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailsScreen(
          campagneId: _fichePostData!.campagneId,
          groupId: groupManager.getGroupId()!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Fiche'),
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
                      _fichePostData?.familyName = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Famille d\'animaux',
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
                      _fichePostData?.description = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Type d\'animal',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      border: InputBorder.none, // Remove the border
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _selectLocation,
                  child: Text('Ajouter une localisation',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 249, 236, 1.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              selectedLocation != null
                  ? Text(
                      'Localisation sélectionnée : ${selectedLocation!.latitude}, ${selectedLocation!.longitude}',
                      style: TextStyle(fontSize: 16),
                    )
                  : Container(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Ajouter une photo',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 249, 236, 1.0),
                  ),
                ),
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: _saveFiche,
                    child: Text('Enregistrer',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 249, 236, 1.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
