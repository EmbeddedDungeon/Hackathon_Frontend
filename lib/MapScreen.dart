import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<LatLng> _mapPoints = [
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
          center: _mapPoints[0],
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
}

List<Marker> _getMarkers(List<LatLng> mapPoints) {
  return mapPoints
      .map(
        (point) => Marker(
      point: point,
      width: 50,
      height: 50,
      builder: (_) => Image.asset('assets/icons/map_point.png'),
    ),
  )
      .toList();
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
