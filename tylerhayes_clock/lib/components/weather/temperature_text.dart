import 'package:flutter/material.dart';

/// Displays [temperature] in text with fontSize [size] and color [color]
class TemperatureText extends StatelessWidget {
  final int temperature;
  final Color color;
  final double size;

  TemperatureText({
    @required this.temperature,
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
