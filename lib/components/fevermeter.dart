
import 'dart:ui';

import 'package:flame/components.dart';

class Clock extends PositionComponent {
  Clock() : super(size: Vector2(224, 130), position: Vector2(-112, -91));

  @override
  final bool debugMode = true;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTRB(0, 0, 224, 130),
      Paint()..color = const Color.fromRGBO(242, 73, 73, 1),
    );
  }
}
