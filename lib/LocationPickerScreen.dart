import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late final MapController _mapController;
  LatLng? selectedLocation;
  double coordUserLatitude = 0;
  double coordUserLongitude = 0;

  @override
  void initState() {
    _mapController = MapController();
    _takeUserGPSCoord(); // Получаем координаты пользователя при инициализации экрана
    super.initState();
  }

  void _takeUserGPSCoord() async {
    LocationService locationService = LocationService();
    try {
      Position currentPosition = await locationService.getCurrentLocation();
      setState(() {
        coordUserLatitude = currentPosition.latitude;
        coordUserLongitude = currentPosition.longitude;
        selectedLocation = LatLng(coordUserLatitude, coordUserLongitude); // Устанавливаем выбранную позицию на текущие координаты пользователя
        _mapController.move(selectedLocation!, 10.0); // Перемещаем карту к текущим координатам пользователя
      });
      print('Latitude: $coordUserLatitude, Longitude: $coordUserLongitude');
    } catch (e) {
      print('Error getting location: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор местоположения'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(coordUserLatitude, coordUserLongitude), // Установим центр карты в координаты пользователя
              zoom: 10.0,
              onTap: (tapPosition, latLng) {
                _handleMapTap(latLng);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
          if (selectedLocation != null)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Image.asset(
                  'lib/assets/images/point.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          if (selectedLocation != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedLocation != null) {
                      Navigator.pop(context, selectedLocation);
                    }
                  },
                  child: const Text('Принять'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleMapTap(LatLng latLng) {
    setState(() {
      selectedLocation = latLng; // Обновляем выбранную позицию на место, куда пользователь нажал на карту
      _mapController.move(latLng, _mapController.zoom); // Перемещаем карту к новым координатам
    });
  }
}

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
