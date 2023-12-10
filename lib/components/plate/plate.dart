import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Plate extends SpriteComponent {
  Plate({required super.position}) : super();

  @override
  FutureOr<void> onLoad() {
    final plateSprite = Sprite(Flame.images.fromCache('plate.png'));

    sprite = plateSprite;

    return super.onLoad();
  }
}
