// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

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
          handsColor: Colors.black87,
          strokeWidth: 10,
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
    this.handsColor: Colors.black54,
    this.strokeWidth: 10,
  });

  @override
  _HourMinuteFaceState createState() => _HourMinuteFaceState();
}

class _HourMinuteFaceState extends State<HourMinuteFace> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (time) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: HourMinuteHandPainter(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.handsColor,
          hourHandLength: .18,
          minuteHandLength: .38,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

/// Paints a single fluid path connecting a minute and hour hand in the center of a circular clock face.
///
/// [hourHandLength] and [minuteHandLength] are values between 0 and .5, and correlate to percent diameter of the clock face.
class HourMinuteHandPainter extends CustomPainter {
  static const degreesPerMinute = 6;
  static const degreesPerHour = 30;

  final double strokeWidth;
  final Color strokeColor;
  final double hourHandLength;
  final double minuteHandLength;

  const HourMinuteHandPainter({
    @required this.strokeWidth,
    @required this.strokeColor,
    @required this.hourHandLength,
    @required this.minuteHandLength,
  })  : assert(hourHandLength >= 0 && hourHandLength <= .5),
        assert(minuteHandLength >= 0 && minuteHandLength <= .5);

  @override
  void paint(Canvas canvas, Size size) {
    final double hour = DateTime.now().hour % 12 + DateTime.now().minute / 60;
    final double minute = DateTime.now().minute + DateTime.now().second / 60;

    final double hourHandX = radialCoordinateX(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
    );
    final double hourHandY = radialCoordinateY(
      distanceFromCenter: hourHandLength,
      angle: hour * degreesPerHour,
    );
    final double minuteHandX = radialCoordinateX(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
    );
    final double minuteHandY = radialCoordinateY(
      distanceFromCenter: minuteHandLength,
      angle: minute * degreesPerMinute,
    );

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(
        hourHandX,
        hourHandY,
      )
      ..conicTo(
        .5,
        .5,
        minuteHandX,
        minuteHandY,
        3,
      );

    final Matrix4 scaleMatrix = Matrix4.identity()
      ..scale(size.width, size.height);

    path = path.transform(
      Float64List.fromList(
        scaleMatrix.storage.toList(),
      ),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

/// Returns a value between -1 and 1
double radialCoordinateY({double distanceFromCenter, num angle}) {
  switch (angle) {
    case 90:
    case 270:
      return .5;
    case 0:
      return .5 - distanceFromCenter;
    case 180:
      return .5 + distanceFromCenter;
  }

  final radians = (angle % 90) * math.pi / 180;

  double angleModifier;

  if (angle < 90)
    angleModifier = math.cos(radians);
  else if (angle < 180)
    angleModifier = math.sin(radians);
  else if (angle < 270)
    angleModifier = math.cos(radians);
  else
    angleModifier = math.sin(radians);

  return .5 +
      (distanceFromCenter * angleModifier) *
          (angle < 270 && angle > 90 ? 1 : -1);
}

/// Returns a value between -1 and 1
double radialCoordinateX({double distanceFromCenter, num angle}) {
  switch (angle) {
    case 0:
    case 180:
      return .5;
    case 270:
      return .5 - distanceFromCenter;
    case 90:
      return .5 + distanceFromCenter;
  }

  final radians = (angle % 90) * math.pi / 180;

  double angleModifier;

  if (angle < 90)
    angleModifier = math.sin(radians);
  else if (angle < 180)
    angleModifier = math.cos(radians);
  else if (angle < 270)
    angleModifier = math.sin(radians);
  else
    angleModifier = math.cos(radians);

  return .5 +
      (distanceFromCenter * angleModifier) *
          (angle < 180 && angle > 0 ? 1 : -1);
}

int degreesPerMinute(int minutes) {
  return minutes * 6;
}

int degreesPerHour(int hours) {
  return hours * 30;
}
