import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'CompassService.dart';
import 'FicheScreen.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;
  double coordUserLatitude = 0;
  double coordUserLongitude = 0;
  late CompassService  _compassReader;

  @override
  void initState() {
    _mapController = MapController();
    _compassReader = CompassService (); // Инициализируем CompassReader
    _compassReader.startReading();
    _takeUserGPSCoord();
    super.initState();
  }

  @override
  void dispose() {
    _compassReader.stopReading(); // Останавливаем чтение угла компаса
    super.dispose();
  }

  void _takeUserGPSCoord() async {
    LocationService locationService = LocationService();
    try {
      Position currentPosition = await locationService.getCurrentLocation();
      setState(() {
        coordUserLatitude = currentPosition.latitude;
        coordUserLongitude = currentPosition.longitude;
        _mapController.move(LatLng(coordUserLatitude, coordUserLongitude), 13.0);
      });
      print('Latitude: $coordUserLatitude, Longitude: $coordUserLongitude');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  List<Marker> _getUserMarker(double compassAngle) {
    return [
      Marker(
        point: LatLng(coordUserLatitude, coordUserLongitude),
        width: 50,
        height: 50,
        builder: (context) {
          return Transform.rotate(
            angle: compassAngle * (3.14 / 180), // Угол в радианах
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Координаты'),
                      content: Text(
                        'Широта: $coordUserLatitude\nДолгота: $coordUserLongitude',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Закрыть'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.asset('lib/assets/images/userpoint.png'),
            ),
          );
        },
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    final List<LatLng> _mapPoints = [
      LatLng(49.123793, -1.644134),
      LatLng(49.223793, -1.644134),
      LatLng(49.323793, -1.644134),
      LatLng(49.423793, -1.644134),
      LatLng(49.523793, -1.644134),
      LatLng(49.623793, -1.644134),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(coordUserLatitude, coordUserLongitude),
          zoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_map_example',
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              size: const Size(50, 50),
              maxClusterRadius: 50,
              markers: _getUserMarker(_compassReader.getCompassAngle()) + _getMarkers(_mapPoints),
              builder: (_, markers) {
                return _ClusterMarker(
                  markersLength: markers.length.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _getMarkers(List<LatLng> mapPoints) {
    return mapPoints
        .map(
          (point) => Marker(
        point: point,
        width: 50,
        height: 50,
        builder: (context) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FicheScreen(ficheId: 1),
              ),
            );
          },
          child: Image.asset('lib/assets/images/point.png'),
        ),
      ),
    )
        .toList();
  }
}

class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({required this.markersLength});

  final String markersLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 3,
        ),
      ),
      child: Center(
        child: Text(
          markersLength,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
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