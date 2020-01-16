import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tylerhayes_clock/components/painters/arc_dot_painter.dart';
import 'package:tylerhayes_clock/utils/constants.dart';

/// Paints a dot of color [color] and size [dotSize] that orbits a circle with radius [radius].
class SecondHand extends StatefulWidget {
  final double radius;
  final Color color;
  final double dotSize;

  const SecondHand({
    this.radius,
    this.color,
    this.dotSize: 10,
  });

  @override
  _SecondHandState createState() => _SecondHandState();
}

class _SecondHandState extends State<SecondHand> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      Duration(milliseconds: 10),
      (time) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double seconds =
        DateTime.now().second + DateTime.now().millisecond / 1000;

    final double secondHandAngle = seconds * degreesPerSecond;

    return CustomPaint(
      painter: ArcDotPainter(
        arcAngles: [secondHandAngle],
        dotSize: widget.dotSize,
        color: widget.color,
        radius: widget.radius,
      ),
    );
  }
}
