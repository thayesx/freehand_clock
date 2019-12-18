import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// [distanceFromCenter] is a value between 0 and 0.5 that correlates to a percentage of the clockFace diameter.
class SecondHand extends StatefulWidget {
  final double distanceFromCenter;
  final Color handColor;
  final double strokeWidth;

  const SecondHand({
    this.distanceFromCenter,
    this.handColor: Colors.black54,
    this.strokeWidth: 10,
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
    final size = widget.distanceFromCenter + widget.strokeWidth;

    return Container(
      child: CustomPaint(
        painter: _SecondHandPainter(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.handColor,
          distanceFromCenter: widget.distanceFromCenter,
        ),
        size: Size(size, size),
      ),
    );
  }
}

/// Paints a second hand as a circle of [strokeWidth] diameter that orbits a circle with [distanceFromCenter] radius.
class _SecondHandPainter extends CustomPainter {
  static const degreesPerSecond = 6;

  final double strokeWidth;
  final Color strokeColor;
  final double distanceFromCenter;

  const _SecondHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.distanceFromCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final seconds = DateTime.now().second + DateTime.now().millisecond / 1000;

    final drawAngleRadians = (seconds * degreesPerSecond - 90) * (pi / 180);

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2),
        radius: distanceFromCenter,
      ),
      drawAngleRadians,
      .001,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
