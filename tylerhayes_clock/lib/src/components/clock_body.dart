import 'package:flutter/material.dart';

import 'shared/hour_minute_hands.dart';
import 'shared/clock_face_ring.dart';
import 'shared/second_hand.dart';

class ClockBody extends StatelessWidget {
  final double radius;
  final double secondHandLength;
  final double minuteHandLength;
  final double hourHandLength;
  final double handsStrokeWidth;
  final double clockFaceTickSize;
  final double handsCurveHardness;
  final Color handsColor;
  final Color clockFaceColor;

  ClockBody({
    @required this.radius,
    @required this.secondHandLength,
    @required this.minuteHandLength,
    @required this.hourHandLength,
    @required this.handsStrokeWidth,
    @required this.clockFaceTickSize,
    this.handsCurveHardness = 1,
    this.handsColor = Colors.black,
    this.clockFaceColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final ClockFaceRing clockFaceRing = ClockFaceRing(
      radius: radius,
      dotSize: clockFaceTickSize,
      color: clockFaceColor,
    );

    final HourMinuteHands hourMinuteHands = HourMinuteHands(
      hourHandLength: hourHandLength,
      minuteHandLength: minuteHandLength,
      strokeWidth: handsStrokeWidth,
      curveHardness: handsCurveHardness,
      color: handsColor,
    );

    final SecondHand secondHand = SecondHand(
      radius: secondHandLength,
      dotSize: handsStrokeWidth,
      color: handsColor,
    );

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        clockFaceRing,
        hourMinuteHands,
        secondHand,
      ],
    );
  }
}
