import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class TemperatureText extends StatelessWidget {
  final int temperature;
  final TemperatureUnit unit;
  final Color color;
  final double size;

  TemperatureText({
    @required this.temperature,
    @required this.unit,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "${temperature.toString()}º",
      style: TextStyle(
        fontFamily: "Hands Numeric",
        color: color,
        fontSize: size,
      ),
    );
  }
}