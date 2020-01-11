import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/weather/temperature_text.dart';
import 'package:tylerhayes_clock/components/weather/weather_condition_icon.dart';
import 'package:tylerhayes_clock/style/colors.dart';

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
    final double margin = 20;
    final double size = 40;

    return Positioned(
      bottom: margin,
      left: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: margin / 2),
            child: WeatherConditionIcon(
              weatherCondition: weatherCondition,
              color: secondaryColor(context),
              size: size,
            ),
          ),
          TemperatureText(
            temperature: temperature.round(),
            unit: temperatureUnit,
            color: secondaryColor(context),
            size: size,
          ),
        ],
      ),
    );
  }
}
