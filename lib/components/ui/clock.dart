import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';

const double _diameterOuter = 83;
const double _diameterInner = 68;
const double _diameterArrow = 21;

class Clock extends PositionComponent {
  double time;
  double gameLength;

  Clock({required this.time, required this.gameLength})
      : super(
          size: Vector2(_diameterOuter, _diameterOuter),
          position: Vector2(560, 17),
        );

  @override
  final bool debugMode = kDebugMode;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      const Offset(_diameterOuter / 2 + shadow, _diameterOuter / 2 + shadow),
      _diameterOuter / 2,
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );
    canvas.drawCircle(
      const Offset(_diameterOuter / 2, _diameterOuter / 2),
      _diameterOuter / 2,
      Paint()..color = const Color.fromRGBO(242, 73, 73, 1),
    );
    canvas.drawCircle(
      const Offset(_diameterOuter / 2, _diameterOuter / 2),
      _diameterInner / 2,
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
      const Offset(_diameterOuter / 2, _diameterOuter / 2),
      _diameterArrow / 2,
      Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
    );

    canvas.drawLine(
      Offset(
        (sin(time / gameLength * (2 * pi)) * _diameterOuter / 2) +
            _diameterOuter / 2,
        (-cos(time / gameLength * (2 * pi)) * _diameterOuter / 2) +
            _diameterOuter / 2,
      ),
      const Offset(_diameterOuter / 2, _diameterOuter / 2),
      Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 1)
        ..strokeWidth = 8,
    );
  }
}
