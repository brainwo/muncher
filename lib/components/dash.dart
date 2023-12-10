import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flamejam/game.dart';
import 'package:flutter/foundation.dart';

class Dash extends PositionComponent
    with DragCallbacks, HasGameReference<MyGame>, CollisionCallbacks {
  Dash() : super(size: Vector2(224, 130), position: Vector2(-112, -91));

  @override
  final bool debugMode = kDebugMode;




  @override
  void render(Canvas canvas) {
  }
}
