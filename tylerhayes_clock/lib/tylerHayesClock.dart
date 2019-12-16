import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/colorScheme.dart';
import 'package:tylerhayes_clock/hourMinuteHands.dart';
import 'package:tylerhayes_clock/secondHand.dart';

class TylerHayesClock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;

    final double strokeWidth = 10;
    final double secondHandLength = (screenSize / 2) - 30;
    final double minuteHandLength = secondHandLength - strokeWidth * 2;
    final double hourHandLength = minuteHandLength * .55;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            HourMinuteHands(
              hourHandLength: hourHandLength,
              minuteHandLength: minuteHandLength,
              strokeWidth: strokeWidth,
              handsColor: handColor(context),
            ),
            SecondHand(
              distanceFromCenter: secondHandLength,
              strokeWidth: strokeWidth,
              handColor: handColor(context),
            )
          ],
        ),
      ),
    );
  }
}