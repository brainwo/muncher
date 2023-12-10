import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';

const double _width = 327;
const double _diameterArrow = 21;
const double _maxTemp = 48;

class Thermometer extends PositionComponent {
  double temp;
  Thermometer({required this.temp})
      : super(size: Vector2(_width, 18), position: Vector2(163, 41));

  @override
  final bool debugMode = kDebugMode;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(shadow, shadow, 78, 18),
      Paint()..color = colorBlack,
    );
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 78, 18),
      Paint()..color = colorCyan,
    );
    canvas.drawRect(
      const Rect.fromLTWH(83 + shadow, shadow, 78, 18),
      Paint()..color = colorBlack,
    );
    canvas.drawRect(
      const Rect.fromLTWH(83, 0, 78, 18),
      Paint()..color = colorYellow,
    );
    canvas.drawRect(
      const Rect.fromLTWH(168 + shadow, shadow, 78, 18),
      Paint()..color = colorBlack,
    );
    canvas.drawRect(
      const Rect.fromLTWH(168, 0, 78, 18),
      Paint()..color = colorYellow,
    );
    canvas.drawRect(
      const Rect.fromLTWH(249 + shadow, shadow, 78, 18),
      Paint()..color = colorBlack,
    );
    canvas.drawRect(
      const Rect.fromLTWH(249, 0, 78, 18),
      Paint()..color = colorMagenta,
    );

    canvas.drawLine(
      Offset(_width * (temp / _maxTemp), -9),
      Offset(_width * (temp / _maxTemp), 18),
      Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 1)
        ..strokeWidth = 8,
    );
    canvas.drawCircle(
      Offset(_width * (temp / _maxTemp), 18 + _diameterArrow / 2),
      _diameterArrow / 2,
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );
  }
}
