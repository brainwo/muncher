import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flamejam/game.dart';

class Dash extends PositionComponent
    with DragCallbacks, HasGameReference<MyGame>, CollisionCallbacks {
  Dash() : super(size: Vector2(224, 130), position: Vector2(-112, -91));

  @override
  final bool debugMode = true;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTRB(0, 0, 224, 130),
      Paint()..color = const Color.fromRGBO(54, 143, 193, 1),
    );
  }
}
