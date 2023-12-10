import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';

const double diameterOuter = 83;
const double diameterInner = 68;
const double diameterArrow = 21;

class Clock extends PositionComponent {
  double time;
  double gameLength;

  Clock({required this.time, required this.gameLength})
      : super(
          size: Vector2(diameterOuter, diameterOuter),
          position: Vector2(560, 17),
        );

  @override
  final bool debugMode = kDebugMode;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      const Offset(diameterOuter / 2 + shadow, diameterOuter / 2 + shadow),
      diameterOuter / 2,
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );
    canvas.drawCircle(
      const Offset(diameterOuter / 2, diameterOuter / 2),
      diameterOuter / 2,
      Paint()..color = const Color.fromRGBO(242, 73, 73, 1),
    );
    canvas.drawCircle(
      const Offset(diameterOuter / 2, diameterOuter / 2),
      diameterInner / 2,
      Paint()..color = const Color.fromRGBO(255, 255, 255, 1),
    );
    canvas.drawVertices(
      Vertices(VertexMode.triangles, [
        const Offset(40, 4),
        const Offset(41, 40),
        const Offset(15, 17),
      ]),
      BlendMode.src,
      Paint()..color = const Color.fromRGBO(250, 103, 103, 1),
    );
    canvas.drawCircle(
      const Offset(diameterOuter / 2, diameterOuter / 2),
      diameterArrow / 2,
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );

    canvas.drawLine(
      Offset(
        (sin(time / gameLength * (2 * pi)) * diameterOuter / 2) +
            diameterOuter / 2,
        (-cos(time / gameLength * (2 * pi)) * diameterOuter / 2) +
            diameterOuter / 2,
      ),
      const Offset(diameterOuter / 2, diameterOuter / 2),
      Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 1)
        ..strokeWidth = 8,
    );
  }
}
