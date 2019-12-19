import 'dart:math';

import 'package:tylerhayes_clock/svg/letters.dart' as letterGroups;

/// Returns a value between -[gridWidth] and [gridWidth]
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

  return gridHeight / 2 +
      (distanceFromCenter * angleModifier) *
          (angle < 270 && angle > 90 ? 1 : -1);
}

/// Returns a value between -[gridWidth] and [gridWidth]
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

  return gridWidth / 2 +
      (distanceFromCenter * angleModifier) *
          (angle < 180 && angle > 0 ? 1 : -1);
}

void addNextAlt<T>(List<T> destination, List<T> source) {
  destination.add(
    source.firstWhere(
      (elem) => !destination.contains(elem),
      orElse: () => source[Random().nextInt(source.length)],
    ),
  );
}

/// Returns a list of number assets using alternates to avoid having two sequential, identical assets
List<String> chainedAssetsFromNum(num number) {
  List<String> assets = [];

  number.toString().codeUnits.forEach(
    (charCode) {
      switch (new String.fromCharCode(charCode)) {
        case "0":
          return addNextAlt(assets, letterGroups.zeroes);
        case "1":
          return addNextAlt(assets, letterGroups.ones);
        case "2":
          return addNextAlt(assets, letterGroups.twos);
        case "3":
          return addNextAlt(assets, letterGroups.threes);
        case "4":
          return addNextAlt(assets, letterGroups.fours);
        case "5":
          return addNextAlt(assets, letterGroups.fives);
        case "6":
          return addNextAlt(assets, letterGroups.sixes);
        case "7":
          return addNextAlt(assets, letterGroups.sevens);
        case "8":
          return addNextAlt(assets, letterGroups.eights);
        case "9":
          return addNextAlt(assets, letterGroups.nines);
      }
    },
  );

  return assets;
}
