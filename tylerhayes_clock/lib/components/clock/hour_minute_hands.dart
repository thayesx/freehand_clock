import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/utils/constants.dart';
import 'package:tylerhayes_clock/utils/tools.dart';

/// Paints minute and hour hands from a single curved stroke of color [color] and width [strokeWidth].
/// [curveHardness] determines the roundedness of the joint connecting both hands. A higher number corresponds to a harder angle.
class HourMinuteHands extends StatefulWidget {
  final double hourHandLength;
  final double minuteHandLength;
  final Color color;
  final double strokeWidth;
  final double curveHardness;

  const HourMinuteHands({
    @required this.hourHandLength,
    @required this.minuteHandLength,
    @required this.color,
    this.curveHardness: 5,
    this.strokeWidth: 10,
  });

  @override
  _HourMinuteHandsState createState() => _HourMinuteHandsState();
}

class _HourMinuteHandsState extends State<HourMinuteHands> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (time) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HourMinuteHandPainter(
        strokeWidth: widget.strokeWidth,
        strokeColor: widget.color,
        hourHandLength: widget.hourHandLength,
        minuteHandLength: widget.minuteHandLength,
        curveHardness: widget.curveHardness,
      ),
    );
  }
}

class _HourMinuteHandPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final double hourHandLength;
  final double minuteHandLength;
  final double curveHardness;

  const _HourMinuteHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.hourHandLength,
    @required this.minuteHandLength,
    @required this.curveHardness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double hour = DateTime.now().hour % 12 + DateTime.now().minute / 60;
    final double minute = DateTime.now().minute + DateTime.now().second / 60;

    final double hourHandX = radialCoordinateX(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
      gridWidth: size.width,
    );
    final double hourHandY = radialCoordinateY(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
      gridHeight: size.height,
    );
    final double minuteHandX = radialCoordinateX(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
      gridWidth: size.width,
    );
    final double minuteHandY = radialCoordinateY(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
      gridHeight: size.height,
    );

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(
        hourHandX,
        hourHandY,
      )
      ..conicTo(
        size.width / 2,
        size.height / 2,
        minuteHandX,
        minuteHandY,
        curveHardness,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}