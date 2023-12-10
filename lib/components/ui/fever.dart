import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';

class Fever extends PositionComponent {
  Fever() : super(size: Vector2(20, 240), position: Vector2(27, 112));

  @override
  final bool debugMode = kDebugMode;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(shadow, shadow, 20, 240),
        const Radius.circular(10),
      ),
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 20, 240),
        const Radius.circular(10),
      ),
      Paint()..color = const Color.fromRGBO(188, 228, 209, 1),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3, 8, 4, 223),
        const Radius.circular(10),
      ),
      Paint()..color = const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
