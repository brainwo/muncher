import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flamejam/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> foodList = [
  {
    'name': 'pepper',
    'property': 2,
    'temp': 'extrahot',
    'position': Vector2(6, 2),
    'size': Vector2(71, 83)
  },
  {
    'name': 'tea',
    'property': 2,
    'temp': 'extrahot',
    'position': Vector2(108, 15),
    'size': Vector2(88, 51),
  },
  {
    'name': 'burger',
    'property': 1,
    'temp': 'hot',
    'position': Vector2(135, 81),
    'size': Vector2(93, 64),
  },
  {
    'name': 'pizza',
    'property': 1,
    'temp': 'hot',
    'position': Vector2(5, 100),
    'size': Vector2(122, 58),
  },
  {
    'name': 'water',
    'property': 0,
    'temp': 'normal',
    'position': Vector2(5, 184),
    'size': Vector2(46, 88),
  },
  {
    'name': 'soda',
    'property': -1,
    'temp': 'cold',
    'position': Vector2(73, 173),
    'size': Vector2(66, 101),
  },
  {
    'name': 'muffin',
    'property': -1,
    'temp': 'cold',
    'position': Vector2(239, 88),
    'size': Vector2(77, 84),
  },
  {
    'name': 'sundae',
    'property': -2,
    'temp': 'supercold',
    'position': Vector2(148, 167),
    'size': Vector2(68, 105),
  },
  {
    'name': 'popsicle',
    'property': -2,
    'temp': 'supercold',
    'position': Vector2(228, 0),
    'size': Vector2(90, 79),
  },
];

enum Temperature {
  extrahot,
  hot,
  normal,
  cold,
  supercold,
}

class Food extends SpriteComponent
    with
        DragCallbacks,
        HasGameReference<MyGame>,
        CollisionCallbacks,
        TapCallbacks,
        HoverCallbacks {
  Food({required this.temp, super.position, super.size, super.sprite});

  factory Food.create() {
    final food = foodList.random();

    final foodSprite = Sprite(
      Flame.images.fromCache('foods.png'),
      srcSize: food['size'] as Vector2,
      srcPosition: food['position'] as Vector2,
    );

    return Food(
      temp: switch (food['temp']) {
        'extrahot' => Temperature.extrahot,
        'hot' => Temperature.hot,
        'normal' => Temperature.normal,
        'cold' => Temperature.cold,
        'supercold' => Temperature.supercold,
        _ => Temperature.normal,
      },
      size: food['size'] as Vector2,
      sprite: foodSprite,
    );
  }

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
    if (sprite == null) {
      canvas.drawRect(
        Rect.fromLTRB(0, 0, size.x, size.y),
        Paint()..color = Colors.blue,
      );
    }
    super.render(canvas);
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
