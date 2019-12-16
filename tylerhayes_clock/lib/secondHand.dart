import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SecondHand extends StatefulWidget {
  final double size;
  final Color handsColor;
  final double strokeWidth;

  const SecondHand({
    this.size: 100,
    this.handsColor: Colors.black54,
    this.strokeWidth: 10,
  });

  @override
  _SecondHandState createState() => _SecondHandState();
}

class _SecondHandState extends State<SecondHand> {
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 1), (time) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: SecondHandPainter(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.handsColor,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

class SecondHandPainter extends CustomPainter {
  static const degreesPerSecond = 6;

  final double strokeWidth;
  final Color strokeColor;

  const SecondHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
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
        radius: size.width / 2 - 20,
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
