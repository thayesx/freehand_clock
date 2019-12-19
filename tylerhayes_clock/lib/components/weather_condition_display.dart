import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tylerhayes_clock/svg/assets.dart' as assets;

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
      alignment: Alignment.centerLeft,
      color: color,
    );
  }
}

String _assetForWeatherCondition(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.cloudy:
      return assets.cloudy;
    case WeatherCondition.foggy:
      return assets.foggy;
    case WeatherCondition.rainy:
      return assets.rainy;
    case WeatherCondition.snowy:
      return assets.snowy;
    case WeatherCondition.sunny:
      return assets.sunny;
    case WeatherCondition.windy:
      return assets.windy;
    case WeatherCondition.thunderstorm:
      return assets.stormy;
    default:
      return null;
  }
}
