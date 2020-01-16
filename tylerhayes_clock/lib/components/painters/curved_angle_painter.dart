import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/utils/tools.dart';

/// Connects two segments with [strokeWidth] into a single curved stroke. A higher [curveHardness] corresponds to a smaller curve radius. Segment angle is defined from the intersection point.
class CurvedAnglePainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final double segment1Angle;
  final double segment1Length;
  final double segment2Angle;
  final double segment2Length;
  final double curveHardness;

  const CurvedAnglePainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.segment1Angle,
    @required this.segment1Length,
    @required this.segment2Angle,
    @required this.segment2Length,
    @required this.curveHardness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double segment1X = radialCoordinateX(
      distanceFromCenter: segment1Length,
      angle: segment1Angle,
    );
    final double segment1Y = radialCoordinateY(
      distanceFromCenter: segment1Length,
      angle: segment1Angle,
    );
    final double segment2X = radialCoordinateX(
      distanceFromCenter: segment2Length,
      angle: segment2Angle,
    );
    final double segment2Y = radialCoordinateY(
      distanceFromCenter: segment2Length,
      angle: segment2Angle,
    );

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(
        segment1X,
        segment1Y,
      )
      ..conicTo(
        0,
        0,
        segment2X,
        segment2Y,
        curveHardness,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
