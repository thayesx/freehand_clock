import 'dart:math';

/// Returns a value between -1 and 1 for the y coordinate value of the terminus of a line starting at (0, 0), with a length of `distanceFromCenter` and angle of `angle`.
double radialCoordinateY({
  double distanceFromCenter,
  num angle,
}) {
  switch (angle) {
    case 90:
    case 270:
      return 0;
    case 0:
      return -distanceFromCenter;
    case 180:
      return distanceFromCenter;
  }

  final radians = radiansFromAngle(angle % 90);

  double multiplier;

  if (angle < 90)
    multiplier = cos(radians);
  else if (angle < 180)
    multiplier = sin(radians);
  else if (angle < 270)
    multiplier = cos(radians);
  else
    multiplier = sin(radians);

  return distanceFromCenter * multiplier * (angle < 270 && angle > 90 ? 1 : -1);
}

/// Returns a value between -1 and 1 for the x coordinate value of the terminus of a line starting at (0, 0), with a length of `distanceFromCenter` and angle of `angle`.
double radialCoordinateX({
  double distanceFromCenter,
  num angle,
}) {
  switch (angle) {
    case 0:
    case 180:
      return 0;
    case 270:
      return -distanceFromCenter;
    case 90:
      return distanceFromCenter;
  }

  final radians = radiansFromAngle(angle % 90);

  double multiplier;

  if (angle < 90)
    multiplier = sin(radians);
  else if (angle < 180)
    multiplier = cos(radians);
  else if (angle < 270)
    multiplier = sin(radians);
  else
    multiplier = cos(radians);

  return distanceFromCenter * multiplier * (angle < 180 && angle > 0 ? 1 : -1);
}

num radiansFromAngle(num angle) {
  return angle * pi / 180;
}
