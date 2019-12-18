import 'dart:math';

import 'package:flutter/material.dart';

class ClockFaceRing extends StatelessWidget {
  final double radius;
  final Color color;
  final double dotSize;

  ClockFaceRing({
    @required this.radius,
    @required this.color,
    @required this.dotSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _ClockFaceRingPainter(
          strokeWidth: dotSize,
          strokeColor: color,
          distanceFromCenter: radius,
        ),
        size: Size(
          radius * 2,
          radius * 2,
        ),
      ),
    );
  }
}

/// Paints a second hand as a circle of [strokeWidth] diameter that orbits a circle with [distanceFromCenter] radius.
class _ClockFaceRingPainter extends CustomPainter {
  static const degreesPerSecond = 6;

  final double strokeWidth;
  final Color strokeColor;
  final double distanceFromCenter;

  const _ClockFaceRingPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.distanceFromCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (num angle in [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330]) {
      final drawAngleRadians = (angle - 90) * (pi / 180);

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.width / 2),
          radius: distanceFromCenter,
        ),
        drawAngleRadians,
        .001,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
