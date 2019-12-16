
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/tools.dart';

class HourMinuteHands extends StatefulWidget {
  final double size;
  final Color handsColor;
  final double strokeWidth;

  const HourMinuteHands({
    this.size: 100,
    this.handsColor: Colors.black54,
    this.strokeWidth: 10,
  });

  @override
  _HourMinuteHandsState createState() => _HourMinuteHandsState();
}

class _HourMinuteHandsState extends State<HourMinuteHands> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (time) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: HourMinuteHandPainter(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.handsColor,
          hourHandLength: .18,
          minuteHandLength: .38,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

/// Paints a single fluid path connecting a minute and hour hand in the center of a circular clock face.
///
/// [hourHandLength] and [minuteHandLength] are values between 0 and .5, and correlate to percent diameter of the clock face.
class HourMinuteHandPainter extends CustomPainter {
  static const degreesPerMinute = 6;
  static const degreesPerHour = 30;

  final double strokeWidth;
  final Color strokeColor;
  final double hourHandLength;
  final double minuteHandLength;

  const HourMinuteHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.hourHandLength,
    @required this.minuteHandLength,
  })  : assert(hourHandLength >= 0 && hourHandLength <= .5),
        assert(minuteHandLength >= 0 && minuteHandLength <= .5);

  @override
  void paint(Canvas canvas, Size size) {
    final double hour = DateTime.now().hour % 12 + DateTime.now().minute / 60;
    final double minute = DateTime.now().minute + DateTime.now().second / 60;

    final double hourHandX = radialCoordinateX(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
    );
    final double hourHandY = radialCoordinateY(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
    );
    final double minuteHandX = radialCoordinateX(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
    );
    final double minuteHandY = radialCoordinateY(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
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
        .5,
        .5,
        minuteHandX,
        minuteHandY,
        3,
      );

    final Matrix4 scaleMatrix = Matrix4.identity()
      ..scale(size.width, size.height);

    path = path.transform(
      Float64List.fromList(
        scaleMatrix.storage.toList(),
      ),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}