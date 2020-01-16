import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/components/clock/clock_face_ring.dart';
import 'package:tylerhayes_clock/components/clock/hour_minute_hands.dart';
import 'package:tylerhayes_clock/components/clock/second_hand.dart';
import 'package:tylerhayes_clock/style/colors.dart';

class ClockBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;

    final double clockFaceRadius = screenSize * .375;

    final double handsStrokeWidth = screenSize / 30;

    final double secondHandLength = clockFaceRadius;
    final double minuteHandLength = clockFaceRadius - handsStrokeWidth * 3;
    final double hourHandLength = clockFaceRadius - handsStrokeWidth * 7;

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          ClockFaceRing(
            radius: clockFaceRadius,
            dotSize: handsStrokeWidth / 2,
            color: secondaryColor(context),
          ),
          HourMinuteHands(
            hourHandLength: hourHandLength,
            minuteHandLength: minuteHandLength,
            strokeWidth: handsStrokeWidth,
            curveHardness: 2.8,
            color: primaryColor(context),
          ),
          SecondHand(
            radius: secondHandLength,
            dotSize: handsStrokeWidth,
            color: primaryColor(context),
          ),
        ],
      ),
    );
  }
}
