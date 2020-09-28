import 'package:flutter/material.dart';


final Color neutralColor = Colors.white24;
final Color solidColor = Colors.white70;
final Color accentColor = lighten(Colors.lightBlueAccent);
final Color backgroundColorLighten = darken(Colors.purpleAccent, .3);
final Color backgroundColor = darken(Colors.deepPurple.shade900, .2);

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}