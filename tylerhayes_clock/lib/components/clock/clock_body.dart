import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/components/clock/clock_face_ring.dart';
import 'package:tylerhayes_clock/components/clock/hour_minute_hands.dart';
import 'package:tylerhayes_clock/components/clock/second_hand.dart';

class ClockBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;

    final double strokeWidth = screenSize / 40;
    final double clockFaceSize = (screenSize / 2) - screenSize * .12;
    // final double secondHandLength = clockFaceSize - strokeWidth * 3;
    final double secondHandLength = clockFaceSize;
    final double minuteHandLength = secondHandLength - strokeWidth * 3;
    final double hourHandLength = minuteHandLength * .55;

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          ClockFaceRing(
            radius: clockFaceSize,
            dotSize: strokeWidth * .65,
            color: Colors.white.withOpacity(.2),
          ),
          HourMinuteHands(
            hourHandLength: hourHandLength,
            minuteHandLength: minuteHandLength,
            strokeWidth: strokeWidth,
            curveHardness: 2.8,
            color: Colors.white.withOpacity(.8),
          ),
          SecondHand(
            radius: secondHandLength,
            dotSize: strokeWidth,
            color: Colors.white.withOpacity(.8),
          ),
        ],
      ),
    );
  }
}
