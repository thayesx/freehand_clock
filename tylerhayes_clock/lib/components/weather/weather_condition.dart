import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherConditionDisplay extends StatelessWidget {
  final WeatherCondition weatherCondition;
  final Color color;

  WeatherConditionDisplay({
    @required this.weatherCondition,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetForWeatherCondition(weatherCondition),
      color: color,
    );
  }
}

String _assetForWeatherCondition(WeatherCondition condition) {
  final _path = 'assets/';

  switch (condition) {
    case WeatherCondition.cloudy:
      return '${_path}cloudy.svg';
    case WeatherCondition.foggy:
      return '${_path}foggy.svg';
    case WeatherCondition.rainy:
      return '${_path}rainy.svg';
    case WeatherCondition.snowy:
      return '${_path}snowy.svg';
    case WeatherCondition.sunny:
      return '${_path}sunny.svg';
    case WeatherCondition.windy:
      return '${_path}windy.svg';
    case WeatherCondition.thunderstorm:
      return '${_path}stormy.svg';
  }

  return null;
}
