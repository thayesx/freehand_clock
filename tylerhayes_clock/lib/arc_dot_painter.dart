import 'dart:math';

import 'package:flutter/material.dart';

/// For every angle value in [arcAngles], ArcDotPainter paints a dot of color [color] and size [dotSize] along a circle with radius [radius].
class ArcDotPainter extends CustomPainter {
  final List<double> arcAngles;
  final double dotSize;
  final Color color;
  final double radius;
  final StrokeCap strokeCap;

  const ArcDotPainter({
    @required this.arcAngles,
    @required this.dotSize,
    @required this.color,
    @required this.radius,
    this.strokeCap = StrokeCap.round,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = dotSize
      ..color = color
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    for (num angle in arcAngles) {
      final angleInRadians = (angle - 90) * (pi / 180);

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.width / 2),
          radius: radius,
        ),
        angleInRadians,
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
