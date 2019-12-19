import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tylerhayes_clock/svg/assets.dart' as assets;
import 'package:tylerhayes_clock/utils/tools.dart';

class TemperatureDisplay extends StatelessWidget {
  final int temperature;
  final TemperatureUnit unit;
  final Color color;
  final double height;

  TemperatureDisplay({
    @required this.temperature,
    @required this.unit,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> digits = chainedAssetsFromNum(temperature)
        .map(
          (asset) => Container(
            height: height,
            width: height * 1.1,
            child: SvgPicture.asset(
              asset,
              color: color,
            ),
          ),
        )
        .toList();

    final Widget degreeSymbol = Container(
      margin: EdgeInsets.only(left: 5),
      height: height,
      width: height * .6,
      child: SvgPicture.asset(
        assets.degrees,
        color: color,
        alignment: Alignment.topCenter,
      ),
    );

    final Widget unitSymbol = Container(
      height: height,
      width: height,
      child: SvgPicture.asset(
        _assetForTempUnit(unit),
        color: color,
      ),
    );

    final List<Widget> widgets = []
      ..addAll(digits)
      ..add(degreeSymbol)
      ..add(unitSymbol);

    return Row(
      children: widgets,
    );
  }
}

String _assetForTempUnit(TemperatureUnit unit) {
  switch (unit) {
    case TemperatureUnit.celsius:
      return assets.c;
    case TemperatureUnit.fahrenheit:
      return assets.f;
  }
  return null;
}
