import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'LocationPickerScreen.dart';
import 'package:http/http.dart' as http; // Добавляем импорт для работы с HTTP

class ImageUploader {
  Future<bool> uploadImages(List<File> images) async {
    // Здесь нужно заменить URL на ваш адрес сервера
    const String apiUrl = 'http://192.168.137.1:8080/upload'; // Замените на ваш URL

    try {
      for (var image in images) {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );

        var response = await request.send();
        if (response.statusCode != 200) {
          return false; // Если одна из загрузок не удалась, возвращаем false
        }
      }
      return true; // Если все изображения были успешно загружены
    } catch (e) {
      print('Error uploading images: $e');
      return false; // Если произошла ошибка при загрузке
    }
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

  // Метод, который преобразует список XFile в список File
  List<File> convertXFilesToFiles(List<XFile> xFiles) {
    List<File> files = [];
    for (var xFile in xFiles) {
      File file = File(xFile.path);
      files.add(file);
    }
    return files;
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
                onPressed: () async {
                  ImageUploader uploader = ImageUploader();

                  if (images.isNotEmpty) {
                    // Преобразование списка XFile в список File
                    List<File> files = convertXFilesToFiles(images);

                    // Загрузка изображений на сервер с помощью ImageUploader
                    bool uploaded = await uploader.uploadImages(files);
                    if (uploaded) {
                      print('Изображения успешно загружены на сервер');
                      // Дополнительные действия после успешной загрузки, если нужно
                    } else {
                      print('Ошибка при загрузке изображений на сервер');
                      // Обработка ошибки загрузки, если нужно
                    }
                  }

                  // Закрытие экрана AddFiche
                  Navigator.pop(context);
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
