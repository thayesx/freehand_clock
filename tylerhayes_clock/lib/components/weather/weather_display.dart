import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:tylerhayes_clock/components/weather/temperature_text.dart';
import 'package:tylerhayes_clock/components/weather/weather_condition_icon.dart';

/// Displays an icon for [weatherCondition] next to the [temperature].
class WeatherDisplay extends StatelessWidget {
  final double temperature;
  final WeatherCondition weatherCondition;
  final double spacing;
  final double size;
  final Color color;

  WeatherDisplay({
    this.temperature,
    this.weatherCondition,
    this.spacing = 0,
    this.size = 20,
    this.color,
  }) : assert(
          weatherCondition != null || temperature != null,
          "Argument for weatherCondition or temperature must be provided.",
        );

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (weatherCondition != null) {
      final EdgeInsetsGeometry padding =
          temperature != null ? EdgeInsets.only(right: spacing) : null;

      children.add(
        Padding(
          padding: padding,
          child: WeatherConditionIcon(
            weatherCondition: weatherCondition,
            color: color,
            size: size,
          ),
        ),
      );
    }

    if (temperature != null) {
      children.add(
        TemperatureText(
          temperature: temperature.round(),
          color: color,
          size: size,
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
