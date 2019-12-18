import 'package:flutter/material.dart';

Color handColor(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  switch (theme.brightness) {
    case Brightness.dark:
      return Colors.white70;
    case Brightness.light:
    default:
      return theme.primaryColor;
  }
}