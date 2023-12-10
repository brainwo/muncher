import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flamejam/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const List<Map<String, dynamic>> food = [
  {'name': 'pepper', 'property': 2},
  {'name': 'tea', 'property': 2},
  {'name': 'burger', 'property': 1},
  {'name': 'pizza', 'property': 1},
  {'name': 'tea', 'property': 0},
  {'name': 'soda', 'property': -1},
  {'name': 'muffin', 'property': -1},
  {'name': 'sundae', 'property': -2},
  {'name': 'popsicle', 'property': -2},
];

enum Temperature {
  extrahot,
  hot,
  normal,
  cold,
  supercold,
}

class Food extends PositionComponent
    with
        DragCallbacks,
        HasGameReference<MyGame>,
        CollisionCallbacks,
        TapCallbacks,
        HoverCallbacks {
  Food({required this.temp, super.position}) : super(size: Vector2(85, 75));

  final Temperature temp;
  late ShapeHitbox hitbox;
  bool _isDragged = false;

  @override
  final bool debugMode = kDebugMode;

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = kDebugMode ? Colors.yellow : Colors.transparent
      ..style = PaintingStyle.stroke;
    hitbox = CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTRB(0, 0, 85, 75),
      Paint()..color = Colors.blue,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    debugColor = _isDragged ? Colors.greenAccent : Colors.purple;
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    priority = 100;

    super.onDragStart(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    super.onDragEnd(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    debugColor = Colors.yellow;
    if (other is ScreenHitbox) {
      removeFromParent();
      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      debugColor = Colors.yellow;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    final topComponent = game.children.last;
    if (topComponent != this) {
      priority = topComponent.priority + 1;
    }
  }
}
