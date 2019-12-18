import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/components/clock_face_ring.dart';
import 'package:tylerhayes_clock/components/hour_minute_hands.dart';
import 'package:tylerhayes_clock/components/second_hand.dart';

class TylerHayesClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;

    final double strokeWidth = screenSize / 40;
    final double clockFaceSize = (screenSize / 2) - screenSize * .12;
    // final double secondHandLength = clockFaceSize - strokeWidth * 3;
    final double secondHandLength = clockFaceSize;
    final double minuteHandLength = secondHandLength - strokeWidth * 3;
    final double hourHandLength = minuteHandLength * .55;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            ClockFaceRing(
              radius: clockFaceSize,
              color: Colors.white.withOpacity(.2),
              dotSize: strokeWidth / 2,
            ),
            HourMinuteHands(
              hourHandLength: hourHandLength,
              minuteHandLength: minuteHandLength,
              strokeWidth: strokeWidth,
              handsColor: Colors.white.withOpacity(.8),
            ),
            SecondHand(
              radius: secondHandLength,
              dotSize: strokeWidth,
              color: Colors.white.withOpacity(.8),
            ),
          ],
        ),
      ),
    );
  }
}