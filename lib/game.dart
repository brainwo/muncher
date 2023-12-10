import 'dart:math';
import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flamejam/components/dash.dart';
import 'package:flamejam/components/plate/food.dart';
import 'package:flamejam/components/plate/plate.dart';
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
  late final Dash dash;
  final imagesLoader = Images();
  late final Image tableBackdrop;
  late final Image tableBackdropFlipped;

  // animation
  late final SpriteAnimation animationEatingNormal;
  late final SpriteAnimation animationEatingHot;
  late final SpriteAnimation animationEatingCold;
  late final SpriteAnimation animationHungryNormal;
  late final SpriteAnimation animationHungryHot;
  late final SpriteAnimation animationHungryCold;

  late final Iterable<Food> foods;

  bool isPlaying = true;

  @override
  Future<void> onLoad() async {
    await Flame.images.load('foods.png');
    await Flame.images.load('table.png');
    await Flame.images.load('plate.png');
    tableBackdrop = await imagesLoader.load('table.png');
    tableBackdropFlipped = await imagesLoader.load('table_flipped.png');

    final spriteSheet = SpriteSheet(
      image: await images.load('eating.png'),
      srcSize: Vector2(220.0, 210.0),
    );

    animationEatingNormal = spriteSheet.createAnimation(row: 0, stepTime: 0.3);
    animationEatingHot = spriteSheet.createAnimation(row: 1, stepTime: 0.3);
    animationEatingCold = spriteSheet.createAnimation(row: 2, stepTime: 0.3);
    animationHungryNormal = spriteSheet.createAnimation(row: 3, stepTime: 0.3);
    animationHungryHot = spriteSheet.createAnimation(row: 4, stepTime: 0.3);
    animationHungryCold = spriteSheet.createAnimation(row: 5, stepTime: 0.3);

    countdown = Timer(gameLength);
    clock = Clock(time: countdown.current, gameLength: gameLength);
    fever = Fever(feverGauge: feverGauge);
    thermo = Thermometer(temp: temp);

    final plates = [
      Plate(position: Vector2(-237, 90)),
      Plate(position: Vector2(-72, 114)),
      Plate(position: Vector2(89, 90)),
    ];

    foods = plates.map((plate) {
      final food = Food.create(
        originPosition:
            plate.position + Vector2(plate.size.x / 2, plate.size.y / 2),
        platePosition: plate.position,
        plateSize: plate.size,
        onEatCallback: (foodTemp) {
          if (temp > 36 &&
              (foodTemp == Temperature.hot ||
                  foodTemp == Temperature.extrahot)) {
            return false;
          }
          if (temp < 12 &&
              (foodTemp == Temperature.cold ||
                  foodTemp == Temperature.supercold)) {
            return false;
          }
          switch (foodTemp) {
            case Temperature.extrahot:
              temp += 6;
            case Temperature.hot:
              temp += 2;
            case Temperature.normal:
              temp += 0;
            case Temperature.cold:
              temp -= 2;
            case Temperature.supercold:
              temp -= 6;
          }
          if (feverGauge < 1) {
            feverGauge += 0.01;
          }
          return true;
        },
      );

      food.originPosition -= Vector2(food.size.x / 2, food.size.y);
      food.position -= Vector2(food.size.x / 2, food.size.y);

      return food;
    });

    dash = Dash(animation: animationEatingNormal);

    add(ScreenHitbox());

    world.add(dash);
    world.addAll(plates);
    world.addAll(foods);

    add(clock);
    add(fever);
    add(thermo);

    FlameAudio.play('game_over.mp3');
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
    if (!isPlaying) {
      super.update(dt);
      return;
    }
    if (foods.every(
          (food) =>
              food.temp == Temperature.cold ||
              food.temp == Temperature.supercold,
        ) &&
        temp < 6) {
      for (final food in foods) {
        food.isDraggable = false;
      }
      FlameAudio.play('game_over.mp3');
      countdown.stop();

      isPlaying = false;
    } else if (foods.every(
          (food) =>
              food.temp == Temperature.hot || food.temp == Temperature.extrahot,
        ) &&
        temp > 42) {
      for (final food in foods) {
        food.isDraggable = false;
      }
      FlameAudio.play('game_over.mp3');
      countdown.stop();
      isPlaying = false;
    } else {
      countdown.update(dt);
    }
    // feverGauge = min((countdown.current * 4) / gameLength, 1);
    // temp = (sin((countdown.current * 5) / gameLength * (2 * pi)) * 24) + 24;
    fever.feverGauge = feverGauge;
    clock.time = countdown.current;
    thermo.temp = temp;

    if (dash.isHovered) {
      if (temp > 36) {
        dash.animation = animationHungryHot;
      } else if (temp < 12) {
        dash.animation = animationHungryCold;
      } else {
        dash.animation = animationHungryNormal;
      }
    } else {
      if (temp > 36) {
        dash.animation = animationEatingHot;
      } else if (temp < 12) {
        dash.animation = animationEatingCold;
      } else {
        dash.animation = animationEatingNormal;
      }
    }

    if (countdown.finished) {
      for (final food in foods) {
        food.isDraggable = false;
      }
      FlameAudio.play('game_over.mp3');
      isPlaying = false;
    }

    if ((gameLength - countdown.current).toInt() == 15) {
      FlameAudio.play('time_up.mp3');
    }
    super.update(dt);
  }
}
