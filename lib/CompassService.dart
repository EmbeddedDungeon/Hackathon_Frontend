import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class CompassService {
  double _angle = 0.0;
  StreamSubscription<CompassEvent>? _subscription;
  late VoidCallback _listener;

  CompassService(VoidCallback listener) {
    _listener = listener;
  }

  void startReading() {
    if (_subscription == null) {
      _subscription = FlutterCompass.events?.listen((CompassEvent event) {
        _angle = event.heading ?? 0.0;
        _listener(); // Вызываем функцию для обновления состояния
        print('Compass angle: $_angle'); // Добавляем принт угла компаса

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
