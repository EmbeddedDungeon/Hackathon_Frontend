import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      _currentPosition = await _determinePosition();
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: _currentPosition != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_currentPosition.latitude}',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Longitude: ${_currentPosition.longitude}',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
