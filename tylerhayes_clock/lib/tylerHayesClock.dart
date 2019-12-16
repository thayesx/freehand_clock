import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/colorScheme.dart';
import 'package:tylerhayes_clock/hourMinuteHands.dart';
import 'package:tylerhayes_clock/secondHand.dart';

class TylerHayesClock extends StatelessWidget {
  static const double clockFaceDiameter = 390;
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
              size: clockFaceDiameter,
              strokeWidth: strokeWidth,
              handsColor: colorScheme.primary,
            ),
            SecondHand(
              size: clockFaceDiameter,
              strokeWidth: strokeWidth,
              handsColor: colorScheme.secondary,
            )
          ],
        ),
      ),
    );
  }
}