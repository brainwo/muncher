import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flamejam/game.dart';
import 'package:flutter/foundation.dart';

class Dash extends SpriteComponent
    with DragCallbacks, HasGameReference<MyGame>, CollisionCallbacks {
  Dash({required super.sprite})
      : super(size: Vector2(220, 210), position: Vector2(-110, -140));

  @override
  final bool debugMode = kDebugMode;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // hands
    canvas.drawOval(
      const Rect.fromLTWH(-25, 160, 58, 34),
      Paint()..color = const Color.fromRGBO(54, 143, 193, 1),
    );
    canvas.drawOval(
      const Rect.fromLTWH(200, 160, 58, 34),
      Paint()..color = const Color.fromRGBO(54, 143, 193, 1),
    );
  }
}
