import 'package:flame/components.dart';
import 'package:flame/flame.dart';

Sprite foodSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('foods.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}
