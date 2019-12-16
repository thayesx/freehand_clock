import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/colorScheme.dart';
import 'package:tylerhayes_clock/hourMinuteHands.dart';
import 'package:tylerhayes_clock/secondHand.dart';

class TylerHayesClock extends StatelessWidget {
  static const double clockFaceRadius = 195;
  static const double hourHandLength = 80;
  static const double minuteHandLength = 145;
  static const double secondHandLength = 165;
  static const double strokeWidth = 10;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = getThemeForContext(context);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Stack(
          children: <Widget>[
            HourMinuteHands(
              clockFaceSize: clockFaceRadius * 2,
              hourHandLength: hourHandLength,
              minuteHandLength: minuteHandLength,
              strokeWidth: strokeWidth,
              handsColor: colorScheme.primary,
            ),
            SecondHand(
              clockFaceSize: clockFaceRadius * 2,
              strokeWidth: strokeWidth,
              handsColor: colorScheme.secondary,
              distanceFromCenter: secondHandLength,
            )
          ],
        ),
      ),
    );
  }
}