import 'package:flutter/material.dart';

const Color neutralColor = Colors.white24;
const Color solidColor = Colors.white70;
final Color accentColor = lighten(Colors.lightBlueAccent);
final Color backgroundColorLighten = darken(Colors.purpleAccent, .3);
final Color backgroundColor = darken(Colors.deepPurple.shade900, .2);

final backgroundGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [backgroundColorLighten, backgroundColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);

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

Color colorByProgress({
  Color begin = solidColor,
  Color end,
  @required double progress,
}) {
  end == null ? end = accentColor : end = end;

  final solidColorEvaluated = begin.withOpacity(1 - progress);
  final accentColorEvaluated = accentColor.withOpacity(progress);

  return Color.alphaBlend(
    solidColorEvaluated,
    accentColorEvaluated,
  );
}
