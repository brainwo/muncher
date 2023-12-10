import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';

class Thermometer extends PositionComponent {
  double temp;
  Thermometer({required this.temp})
      : super(size: Vector2(327, 18), position: Vector2(163, 41));

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
  }
}
