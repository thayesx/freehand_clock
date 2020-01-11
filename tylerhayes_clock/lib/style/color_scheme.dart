import 'package:flutter/material.dart';

Color primaryColor(BuildContext context) {
  final ThemeData theme = Theme.of(context);

  switch (theme.brightness) {
    case Brightness.dark:
      return Colors.white.withOpacity(.8);
    case Brightness.light:
      return Colors.black.withOpacity(.85);
  }

  return null;
}

Color secondaryColor(BuildContext context) {
  final ThemeData theme = Theme.of(context);

  switch (theme.brightness) {
    case Brightness.dark:
      return Colors.white.withOpacity(.3);
    case Brightness.light:
      return Colors.black.withOpacity(.3);
  }

  return null;
}

Color backgroundColor(BuildContext context) {
  final ThemeData theme = Theme.of(context);

  switch (theme.brightness) {
    case Brightness.dark:
      return Colors.black;
    case Brightness.light:
      return Colors.white.withOpacity(.1);
  }

  return null;
}
