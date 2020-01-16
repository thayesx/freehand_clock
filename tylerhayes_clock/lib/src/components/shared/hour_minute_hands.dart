import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/src/utils/constants.dart';

import 'painters/curved_angle_painter.dart';

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
    this.curveHardness,
    this.strokeWidth,
  });

  @override
  _HourMinuteHandsState createState() => _HourMinuteHandsState();
}

class _HourMinuteHandsState extends State<HourMinuteHands> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      // Duration(seconds: 1),
      Duration(milliseconds: 50),
      (_) => setState(() {}),
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
    final double hour = DateTime.now().hour % 12 + DateTime.now().minute / 60;
    final double minute = DateTime.now().minute + DateTime.now().second / 60;

    final double hourHandAngle = hour * degreesPerHour;
    final double minuteHandAngle = minute * degreesPerMinute;

    return CustomPaint(
      painter: CurvedAnglePainter(
        strokeWidth: widget.strokeWidth,
        strokeColor: widget.color,
        segment1Length: widget.hourHandLength,
        segment1Angle: hourHandAngle,
        segment2Length: widget.minuteHandLength,
        segment2Angle: minuteHandAngle,
        curveHardness: widget.curveHardness,
      ),
    );
  }
}
