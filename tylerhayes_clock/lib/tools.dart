import 'dart:math';

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

  final radians = (angle % 90) * pi / 180;

  double angleModifier;

  if (angle < 90)
    angleModifier = cos(radians);
  else if (angle < 180)
    angleModifier = sin(radians);
  else if (angle < 270)
    angleModifier = cos(radians);
  else
    angleModifier = sin(radians);

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

  final radians = (angle % 90) * pi / 180;

  double angleModifier;

  if (angle < 90)
    angleModifier = sin(radians);
  else if (angle < 180)
    angleModifier = cos(radians);
  else if (angle < 270)
    angleModifier = sin(radians);
  else
    angleModifier = cos(radians);

  return .5 +
      (distanceFromCenter * angleModifier) *
          (angle < 180 && angle > 0 ? 1 : -1);
}
