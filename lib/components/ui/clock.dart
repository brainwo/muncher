import 'dart:ui';

import 'package:flame/components.dart';

class Clock extends PositionComponent {
  Clock() : super(size: Vector2(83, 83), position: Vector2(560, 17));

  @override
  final bool debugMode = true;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(560, 17, 83, 83),
      Paint()..color = const Color.fromRGBO(242, 73, 73, 1),
    );
  }
}
