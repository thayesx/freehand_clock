import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/weather/temperature_display.dart';
import 'package:tylerhayes_clock/components/weather/weather_condition.dart';

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
    final double margin = 25;

    final double size = 40;

    return Positioned(
      bottom: margin,
      left: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: margin / 2),
            height: size,
            width: size,
            child: WeatherConditionDisplay(
              weatherCondition: weatherCondition,
              color: Colors.white.withOpacity(.8),
            ),
          ),
          TemperatureDisplay(
            temperature: temperature.round(),
            unit: temperatureUnit,
            color: Colors.white.withOpacity(.8),
            size: size,
          ),
        ],
      ),
    );
  }
}
