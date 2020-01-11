import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/clock/clock_body.dart';
import 'package:tylerhayes_clock/components/weather/weather_temperature_display.dart';
import 'package:tylerhayes_clock/style/color_scheme.dart';

class TylerHayesClock extends StatelessWidget {
  final ClockModel model;

  TylerHayesClock(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Stack(
        children: <Widget>[
          ClockBody(),
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
