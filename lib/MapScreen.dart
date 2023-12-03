import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;
  double coordUserLatitude = 0;
  double coordUserLongitude = 0;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
    _takeUserGPSCoord();
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

  @override
  Widget build(BuildContext context) {
    final List<LatLng> _mapPoints = [
      LatLng(coordUserLatitude, coordUserLongitude),
      LatLng(55.755793, 37.617134),
      LatLng(55.095960, 38.765519),
      LatLng(56.129038, 40.406502),
      LatLng(54.513645, 36.261268),
      LatLng(54.193122, 37.617177),
      LatLng(54.629540, 39.741809),
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
              markers: _getMarkers(_mapPoints),
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Координаты'),
                  content: Text(
                    'Широта: ${point.latitude}\nДолгота: ${point.longitude}',
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
          child: Image.asset('assets/icons/map_point.png'),
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
