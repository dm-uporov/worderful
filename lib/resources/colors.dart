import 'package:flutter/material.dart';

const Color neutralColor = Colors.white24;
final Color solidColor = Colors.grey.shade400;
final Color backgroundColorLighten = darken(Colors.purpleAccent, .3);
final Color backgroundColor = darken(Colors.deepPurple.shade900, .2);

const Color cycleRedDark = Color.fromRGBO(21, 5, 54, 1);
const Color cycleRedMain = Color.fromRGBO(107, 10, 120, 1);
const Color cycleRedAccent = Color.fromRGBO(176, 0, 126, 1);
const Color cycleBlueDark = Color.fromRGBO(21, 12, 41, 1);
const Color cycleBlueMain = Color.fromRGBO(2, 92, 162, 1);
const Color cycleBlueAccent = Color.fromRGBO(15, 219, 250, 1);


final backgroundGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [cycleRedMain, cycleRedDark],
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
  Color begin,
  Color end,
  @required double progress,
}) {
  begin == null ? begin = solidColor : begin = begin;
  end == null ? end = cycleBlueAccent : end = end;

  final solidColorEvaluated = begin.withOpacity(1 - progress);
  final accentColorEvaluated = end.withOpacity(progress);

  return Color.alphaBlend(
    solidColorEvaluated,
    accentColorEvaluated,
  );
}
