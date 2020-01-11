import 'dart:math';

/// Returns a value between 0 and [gridHeight] for the y coordinate value of the terminus of a line starting at (y = [gridHeight / 2]), with a length of [distanceFromCenter] and angle of [angle]
double radialCoordinateY({
  double distanceFromCenter,
  num angle,
  num gridHeight = 1,
}) {
  switch (angle) {
    case 90:
    case 270:
      return gridHeight / 2;
    case 0:
      return gridHeight / 2 - distanceFromCenter;
    case 180:
      return gridHeight / 2 + distanceFromCenter;
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

  return gridHeight / 2 +
      (distanceFromCenter * multiplier) *
          (angle < 270 && angle > 90 ? 1 : -1);
}

/// Returns a value between 0 and [gridWidth] for the x coordinate value of the terminus of a line starting at (x = [gridWidth / 2]), with a length of [distanceFromCenter] and angle of [angle]
double radialCoordinateX({
  double distanceFromCenter,
  num angle,
  num gridWidth = 1,
}) {
  switch (angle) {
    case 0:
    case 180:
      return gridWidth / 2;
    case 270:
      return gridWidth / 2 - distanceFromCenter;
    case 90:
      return gridWidth / 2 + distanceFromCenter;
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

  return gridWidth / 2 +
      (distanceFromCenter * multiplier) *
          (angle < 180 && angle > 0 ? 1 : -1);
}

num radiansFromAngle(num angle) {
  return angle * pi / 180;
}
