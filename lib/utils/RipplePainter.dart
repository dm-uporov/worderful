import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';

class RipplePainter extends CustomPainter {
  RipplePainter(
    this.touchPoints,
    this.currentTime,
    this.maxRippleSize,
    this.waveDuration,
    mainColor,
  )   : mainPaint = Paint()
          ..color = mainColor
          ..strokeWidth = 5.0
          ..style = PaintingStyle.stroke
          ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        shadowPaint = Paint()
          ..color = darken(mainColor)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        lightPaint = Paint()
          ..color = lighten(mainColor)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5);

  final List<TouchPoint> touchPoints;
  final int currentTime;
  final double maxRippleSize;
  final int waveDuration;

  final Paint mainPaint;
  final Paint shadowPaint;
  final Paint lightPaint;

  @override
  void paint(Canvas canvas, Size size) {
    touchPoints.forEach((point) {
      final timePassed = currentTime - point.fromTime;
      final rippleProgress = timePassed.toDouble() / waveDuration.toDouble();
      final rippleSize = maxRippleSize * rippleProgress;
      paintOneRipple(canvas, point.point, rippleSize);
    });
  }

  void paintOneRipple(Canvas canvas, Offset center, double rippleSize) {
    Path path = Path()
      ..addOval(Rect.fromCircle(
        center: center,
        radius: rippleSize,
      ));
    Path shadow = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(center.dx + 2, center.dy + 2),
        radius: rippleSize,
      ));
    Path light = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(center.dx - 2, center.dy - 2),
        radius: rippleSize,
      ));
    canvas.drawPath(shadow, shadowPaint);
    canvas.drawPath(light, lightPaint);
    canvas.drawPath(path, mainPaint);
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return touchPoints.isNotEmpty;
  }
}

class TouchPoint {
  final Offset point;
  final int fromTime;

  TouchPoint(this.point, this.fromTime);
}
