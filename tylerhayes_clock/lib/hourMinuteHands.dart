import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/tools.dart';

class HourMinuteHands extends StatefulWidget {
  final double clockFaceSize;
  final double hourHandLength;
  final double minuteHandLength;
  final Color handsColor;
  final double strokeWidth;

  const HourMinuteHands({
    @required this.clockFaceSize,
    @required this.hourHandLength,
    @required this.minuteHandLength,
    this.handsColor: Colors.black54,
    this.strokeWidth: 10,
  })  : assert(hourHandLength < clockFaceSize / 2,
            "hourHandLength can't be longer than clock face radius. Currently overflowing by ${hourHandLength - clockFaceSize / 2} units."),
        assert(minuteHandLength < clockFaceSize / 2,
            "minuteHandLength can't be longer than clock face radius. Currently overflowing by ${minuteHandLength - clockFaceSize / 2} units.");

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
    return Container(
      child: CustomPaint(
        painter: _HourMinuteHandPainter(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.handsColor,
          hourHandLength: widget.hourHandLength,
          minuteHandLength: widget.minuteHandLength,
        ),
        size: Size(widget.clockFaceSize, widget.clockFaceSize),
      ),
    );
  }
}

/// Paints a single fluid path connecting a minute and hour hand in the center of a circular clock face.
class _HourMinuteHandPainter extends CustomPainter {
  static const degreesPerMinute = 6;
  static const degreesPerHour = 30;

  final double strokeWidth;
  final Color strokeColor;
  final double hourHandLength;
  final double minuteHandLength;

  const _HourMinuteHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.hourHandLength,
    @required this.minuteHandLength,
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
        3,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
