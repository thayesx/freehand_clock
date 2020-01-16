import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'components/index.dart';
import 'style/colors.dart';

class TylerHayesClock extends StatelessWidget {
  final ClockModel model;

  TylerHayesClock(this.model);

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;
    
    final double clockFaceRadius = screenSize * .375;
    final double unit = screenSize / 30;

    final ClockBody clockBody = ClockBody(
      radius: clockFaceRadius,
      secondHandLength: clockFaceRadius,
      minuteHandLength: clockFaceRadius - unit * 3,
      hourHandLength: clockFaceRadius - unit * 6,
      handsStrokeWidth: unit,
      clockFaceTickSize: unit / 2,
      handsCurveHardness: unit / 5,
      handsColor: primaryColor(context),
      clockFaceColor: secondaryColor(context),
    );

    final double weatherDisplayMargin = screenSize / 20;

    final WeatherDisplay weatherDisplay = WeatherDisplay(
      temperature: model.temperature,
      weatherCondition: model.weatherCondition,
      spacing: weatherDisplayMargin / 2,
      size: screenSize / 9,
      color: secondaryColor(context),
    );

    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Stack(
        children: <Widget>[
          Center(
            child: clockBody,
          ),
          Positioned(
            bottom: weatherDisplayMargin,
            left: weatherDisplayMargin,
            child: weatherDisplay,
          )
        ],
      ),
    );
  }
}
