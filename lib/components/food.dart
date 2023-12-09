import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flamejam/game.dart';
import 'package:flutter/material.dart';

enum Temperature {
  hot,
  cold,
}

class Food extends PositionComponent
    with
        DragCallbacks,
        HasGameReference<MyGame>,
        CollisionCallbacks,
        TapCallbacks,
        HoverCallbacks {
  final Temperature temp;

  Food(this.temp) : super(size: Vector2(85, 75));

  late ShapeHitbox hitbox;

  @override
  final bool debugMode = true;

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.yellow
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
    debugColor = isDragged ? Colors.greenAccent : Colors.purple;
  }

  @override
  void onDragStart(DragStartEvent event) {
    priority = 100;

    super.onDragStart(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
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
    print("jomama");
  }
}
