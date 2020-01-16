import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/utils/tools.dart';

/// For every angle value in [arcAngles], ArcDotPainter paints a dot of color [color] and size [dotSize] at a corresponding point on the border of a circle with radius [radius].
class ArcDotPainter extends CustomPainter {
  final List<double> arcAngles;
  final double dotSize;
  final Color color;
  final double radius;

  const ArcDotPainter({
    @required this.arcAngles,
    @required this.dotSize,
    @required this.color,
    @required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = dotSize
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (num angle in arcAngles) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.width / 2),
          radius: radius,
        ),
        radiansFromAngle(angle - 90),
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
