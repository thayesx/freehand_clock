// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  // This creates a clock that enables you to customize it.
  //
  // The [ClockCustomizer] takes in a [ClockBuilder] that consists of:
  //  - A clock widget (in this case, [AnalogClock])
  //  - A model (provided to you by [ClockModel])
  // For more information, see the flutter_clock_helper package.
  //
  // Your job is to edit [AnalogClock], or replace it with your own clock
  // widget. (Look in analog_clock.dart for more details!)
  runApp(ClockCustomizer((ClockModel model) => BezierTest(model)));
}

class BezierTest extends StatelessWidget {
  final ClockModel model;

  BezierTest(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HourMinuteFace(
          size: 390,
        ),
      ),
    );
  }
}

class HourMinuteFace extends StatefulWidget {
  final double size;
  final Color handsColor;
  final double strokeWidth;

  const HourMinuteFace({
    this.size: 100,
    this.handsColor: Colors.black87,
    this.strokeWidth: 10,
  });

  @override
  _HourMinuteFaceState createState() => _HourMinuteFaceState();
}

class _HourMinuteFaceState extends State<HourMinuteFace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: HourMinuteHandPainter(
          strokeWidth: widget.strokeWidth,
          hourHandLength: .18,
          minuteHandLength: .38,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

class HourMinuteHandPainter extends CustomPainter {
  final double strokeWidth;
  final double hourHandLength;
  final double minuteHandLength;

  const HourMinuteHandPainter({
    @required this.strokeWidth,
    @required this.hourHandLength,
    @required this.minuteHandLength,
  })  : assert(hourHandLength > 0 && hourHandLength < 1),
        assert(minuteHandLength > 0 && minuteHandLength < 1);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double radiansPerHour = 30 * math.pi / 180;
    final double radiansPerMin = 6 * math.pi / 180;

    // all coordinates from top left
    double hourX(int hour) {
      switch (hour) {
        case 0:
        case 6:
          return .5;
        case 3:
          return .5 + hourHandLength;
        case 9:
          return .5 - hourHandLength;
      }

      final angle = radiansPerHour * (hour % 3);

      double angleModifier;
      if (hour < 3)
        angleModifier = math.sin(angle);
      else if (hour < 6)
        angleModifier = math.cos(angle);
      else if (hour < 9)
        angleModifier = math.sin(angle);
      else
        angleModifier = math.cos(angle);

      return .5 +
          hourHandLength * angleModifier * (hour < 6 && hour > 0 ? 1 : -1);
    }

    double hourY(int hour) {
      switch (hour) {
        case 3:
        case 9:
          return .5;
        case 0:
          return .5 - hourHandLength;
        case 6:
          return .5 + hourHandLength;
      }

      final angle = radiansPerHour * (hour % 3);

      double angleModifier;
      if (hour < 3)
        angleModifier = math.cos(angle);
      else if (hour < 6)
        angleModifier = math.sin(angle);
      else if (hour < 9)
        angleModifier = math.cos(angle);
      else
        angleModifier = math.sin(angle);

      return .5 +
          hourHandLength * angleModifier * (hour < 9 && hour > 3 ? 1 : -1);
    }

    double minuteX(int minute) {
      switch (minute) {
        case 0:
        case 30:
          return .5;
        case 15:
          return .5 + minuteHandLength;
        case 45:
          return .5 - minuteHandLength;
      }

      final angle = radiansPerMin * (minute % 15);

      double angleModifier;
      if (minute < 15)
        angleModifier = math.sin(angle);
      else if (minute < 30)
        angleModifier = math.cos(angle);
      else if (minute < 45)
        angleModifier = math.sin(angle);
      else
        angleModifier = math.cos(angle);

      return .5 +
          minuteHandLength *
              angleModifier *
              (minute < 30 && minute > 0 ? 1 : -1);
    }

    double minuteY(int minute) {
      switch (minute) {
        case 15:
        case 45:
          return .5;
        case 0:
          return .5 - minuteHandLength;
        case 30:
          return .5 + minuteHandLength;
      }

      final angle = radiansPerMin * (minute % 15);

      double angleModifier;
      if (minute < 15)
        angleModifier = math.cos(angle);
      else if (minute < 30)
        angleModifier = math.sin(angle);
      else if (minute < 45)
        angleModifier = math.cos(angle);
      else
        angleModifier = math.sin(angle);

      return .5 +
          minuteHandLength *
              angleModifier *
              (minute < 45 && minute > 15 ? 1 : -1);
    }

    final _hour = 11;
    final _minute = 5;

    // draw path from hour hand terminal
    path.conicTo(
      size.width * (.5 - hourX(_hour)),
      size.height * (.5 - hourY(_hour)),
      size.width * (minuteX(_minute) - hourX(_hour)),
      size.height * (minuteY(_minute) - hourY(_hour)),
      3,
    );

    // center path in clock face by adjusting fromqath starting point
    path = path.shift(
      Offset(hourX(_hour) * size.width, hourY(_hour) * size.height),
    );

    paint.color = Colors.black87;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
