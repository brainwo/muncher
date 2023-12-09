import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flamejam/components/clock.dart';

import 'package:flamejam/components/dash.dart';
import 'package:flamejam/components/food.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

const double gameLength = 120;

class MyGame extends FlameGame {
  double feverGauge = 0;
  late Timer countdown;
  final TextPaint textConfig = TextPaint(
    style: const TextStyle(color: Colors.black, fontSize: 20),
  );

  @override
  Future<void> onLoad() async {
    countdown = Timer(gameLength);

    final foods = [
      Food(Temperature.hot),
      Food(Temperature.hot),
      Food(Temperature.hot),
    ];
    final dash = Dash();

    final clock = Clock();

    add(clock);

    world.add(dash);
    world.addAll(foods);

    add(ScreenHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 656, 257),
      Paint()..color = const Color.fromRGBO(255, 255, 255, 1),
    );
    canvas.drawRect(
      const Rect.fromLTWH(0, 257, 656, 33),
      Paint()..color = const Color.fromRGBO(156, 81, 81, 1),
    );
    canvas.drawRect(
      const Rect.fromLTWH(0, 290, 656, 164),
      Paint()..color = const Color.fromRGBO(197, 121, 66, 1),
    );

    super.render(canvas);

    if (kDebugMode) {
      textConfig.render(
        canvas,
        'Fever: ${feverGauge / 1}%',
        Vector2(30, 30),
      );
      textConfig.render(
        canvas,
        'Temp: 24 °C',
        Vector2(30, 60),
      );
      textConfig.render(
        canvas,
        'Countdown: ${(gameLength - countdown.current).toStringAsPrecision(3)}',
        Vector2(30, 90),
      );
    }
  }

  @override
  void update(double dt) {
    countdown.update(dt);
    super.update(dt);
  }
}
