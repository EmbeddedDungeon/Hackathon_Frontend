import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Создайте контроллер карты
    GoogleMapController mapController;

    // Начальные координаты (пример - центр города Нью-Йорка)
    LatLng initialCameraPosition = LatLng(40.7128, -74.0060);

    // Создайте список маркеров (пример - точка в центре карты)
    Set<Marker> markers = {
      Marker(
        markerId: MarkerId("1"),
        position: initialCameraPosition,
        infoWindow: InfoWindow(title: "Marker Title", snippet: "Marker Snippet"),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Map Screen"),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: initialCameraPosition,
          zoom: 12.0, // Уровень масштабирования карты
        ),
        markers: markers,
      ),
    );
  }
}
