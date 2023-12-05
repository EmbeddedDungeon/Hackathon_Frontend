import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';

class CompassService  {
  double _angle = 0.0;
  StreamSubscription<CompassEvent>? _subscription;

  void startReading() {
    if (_subscription == null) {
      _subscription = FlutterCompass.events?.listen((CompassEvent event) {
        _angle = event.heading ?? 0.0;
      });
    }
  }

  void stopReading() {
    _subscription?.cancel();
    _subscription = null;
  }

  double getCompassAngle() {
    return _angle;
  }
}