import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'shared/temperature_text.dart';
import 'shared/weather_condition_icon.dart';

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

      final Widget weatherConditionIcon = Padding(
        padding: padding,
        child: WeatherConditionIcon(
          weatherCondition: weatherCondition,
          color: color,
          size: size,
        ),
      );

      children.add(weatherConditionIcon);
    }

    if (temperature != null) {
      final temperatureText = TemperatureText(
        temperature: temperature.round(),
        color: color,
        size: size,
      );

      children.add(temperatureText);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
