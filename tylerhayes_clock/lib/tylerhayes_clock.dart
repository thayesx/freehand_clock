import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/clock/clock_body.dart';
import 'package:tylerhayes_clock/components/weather/weather_display.dart';
import 'package:tylerhayes_clock/style/colors.dart';

class TylerHayesClock extends StatelessWidget {
  final ClockModel model;

  TylerHayesClock(this.model);

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.shortestSide;
    final double clockFaceRadius = screenSize * .375;
    final double handsStrokeWidth = screenSize / 30;

    final Color handsColor = primaryColor(context);
    final Color clockFaceColor = secondaryColor(context);

    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Stack(
        children: <Widget>[
          Center(
            child: ClockBody(
              radius: clockFaceRadius,
              secondHandLength: clockFaceRadius,
              minuteHandLength: clockFaceRadius - handsStrokeWidth * 3,
              hourHandLength: clockFaceRadius - handsStrokeWidth * 7,
              handsStrokeWidth: handsStrokeWidth,
              clockFaceTickSize: handsStrokeWidth / 2,
              handsCurveHardness: 2.8,
              handsColor: handsColor,
              clockFaceColor: clockFaceColor,
            ),
          ),
          WeatherDisplay(
            temperatureUnit: model.unit,
            temperature: model.temperature,
            weatherCondition: model.weatherCondition,
          )
        ],
      ),
    );
  }
}
