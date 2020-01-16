import 'package:flutter/material.dart';

import 'painters/arc_dot_painter.dart';

/// Paints 12 dots of color [color] and size [dotSize] spaced uniformly around the border of a circle with radius [radius]
class ClockFaceRing extends StatelessWidget {
  final double radius;
  final Color color;
  final double dotSize;

  ClockFaceRing({
    @required this.radius,
    @required this.color,
    @required this.dotSize,
  });

  static const List<double> _tickMarkAngles = [
    0,
    30,
    60,
    90,
    120,
    150,
    180,
    210,
    240,
    270,
    300,
    330,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcDotPainter(
        arcAngles: _tickMarkAngles,
        dotSize: dotSize,
        color: color,
        radius: radius,
      ),
    );
  }
}
