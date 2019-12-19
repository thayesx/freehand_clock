import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/clock_body.dart';
import 'package:tylerhayes_clock/components/temperature_display.dart';
import 'package:tylerhayes_clock/components/weather_condition_display.dart';

class TylerHayesClock extends StatelessWidget {
  final ClockModel model;

  TylerHayesClock(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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

class WeatherDisplay extends StatelessWidget {
  final TemperatureUnit temperatureUnit;
  final double temperature;
  final WeatherCondition weatherCondition;

  WeatherDisplay({
    this.temperatureUnit,
    this.temperature,
    this.weatherCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      left: 25,
      child: Column(
        children: [
          TemperatureDisplay(
            temperature: temperature.round(),
            unit: temperatureUnit,
            color: Colors.white.withOpacity(.8),
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 20,
            child: WeatherConditionDisplay(
              weatherCondition: weatherCondition,
              color: Colors.white.withOpacity(.8),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
