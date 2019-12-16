import 'package:flutter/material.dart';

ColorScheme darkScheme = ColorScheme.dark().copyWith(
  background: Colors.black87,
  primary: Colors.white54,
  secondary: Colors.red,
);

ColorScheme lightScheme = ColorScheme.light().copyWith(
  background: Colors.white,
  primary: Colors.black87,
  secondary: Colors.redAccent,
);

ColorScheme getThemeForContext(BuildContext context) {
  switch (Theme.of(context).brightness) {
    case Brightness.dark:
      return darkScheme;
    case Brightness.light:
    default:
      return lightScheme;
  }
}