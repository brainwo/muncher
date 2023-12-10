import 'dart:math';
import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:flamejam/components/dash.dart';
import 'package:flamejam/components/plate/food.dart';
import 'package:flamejam/components/ui/clock.dart';
import 'package:flamejam/components/ui/fever.dart';
import 'package:flamejam/components/ui/thermo.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' hide Image;

const double gameLength = 120;

class MyGame extends FlameGame {
  double feverGauge = 0;
  double temp = 24;
  late Timer countdown;
  final TextPaint textConfig = TextPaint(
    style: const TextStyle(color: Colors.black, fontSize: 14),
  );
  late final Clock clock;
  late final Fever fever;
  late final Thermometer thermo;
  final imagesLoader = Images();
  late final Image tableBackdrop;
  late final Image tableBackdropFlipped;

  @override
  Future<void> onLoad() async {
    await Flame.images.load('foods.png');
    await Flame.images.load('table.png');
    tableBackdrop = await imagesLoader.load('table.png');
    tableBackdropFlipped = await imagesLoader.load('table_flipped.png');

    final sprite = await loadSprite('eating_normal_1.png');

    countdown = Timer(gameLength);
    clock = Clock(time: countdown.current, gameLength: gameLength);
    fever = Fever(feverGauge: feverGauge);
    thermo = Thermometer(temp: temp);

    final foods = [
      Food(temp: Temperature.hot, position: Vector2(-182, 75)),
      Food(temp: Temperature.hot, position: Vector2(-32, 86)),
      Food(temp: Temperature.hot, position: Vector2(108, 75)),
    ];
    final dash = Dash(sprite: sprite);

    add(ScreenHitbox());

    world.add(dash);
    world.addAll(foods);

    add(clock);
    add(fever);
    add(thermo);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 656, 150),
      Paint()..color = const Color.fromRGBO(255, 255, 255, 1),
    );
    canvas.drawRect(
      const Rect.fromLTWH(0, 150, 656, 125),
      Paint()..color = const Color.fromRGBO(237, 237, 237, 1),
    );
    canvas.drawImage(tableBackdrop, const Offset(526, 115), Paint());
    canvas.drawImage(tableBackdropFlipped, const Offset(0, 115), Paint());
    canvas.drawRect(
      const Rect.fromLTWH(0, 257, 656, 33),
      Paint()..color = const Color.fromRGBO(156, 81, 81, 1),
    );
    canvas.drawRect(
      const Rect.fromLTWH(0, 290, 656, 164),
      Paint()..color = const Color.fromRGBO(197, 121, 66, 1),
    );
    canvas.drawOval(
      const Rect.fromLTWH(170, 255, 316, 32),
      Paint()..color = const Color.fromRGBO(123, 67, 67, 1),
    );

    super.render(canvas);

    if (kDebugMode) {
      textConfig.render(
        canvas,
        'Fever: ${(feverGauge * 100).toStringAsFixed(1)}%',
        Vector2(30, 30),
      );
      textConfig.render(
        canvas,
        'Temp: ${temp.toStringAsFixed(1)} °C',
        Vector2(30, 50),
      );
      textConfig.render(
        canvas,
        'Countdown: ${(gameLength - countdown.current).toInt()}',
        Vector2(30, 70),
      );
    }
  }

  @override
  void update(double dt) {
    countdown.update(dt);
    feverGauge = min((countdown.current * 4) / gameLength, 1);
    temp = (sin(countdown.current / gameLength * (2 * pi)) * 24) + 24;
    fever.feverGauge = feverGauge;
    clock.time = countdown.current;
    thermo.temp = temp;

    super.update(dt);
  }
}
