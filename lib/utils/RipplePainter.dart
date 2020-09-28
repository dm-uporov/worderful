import 'dart:ui';

import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  RipplePainter(
    this.touchPoints,
    this.currentTime,
    this.maxRippleSize,
    this.waveDuration, {
    this.blurSigma = 6.0,
  })  : shadowPaint = Paint()
          ..color = Colors.black12.withOpacity(blurSigma / 20) //0.08)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..imageFilter =
              ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        lightPaint = Paint()
          ..color = Colors.white10.withOpacity(blurSigma / 40) //0.04)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..imageFilter =
              ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma);

  final List<TouchPoint> touchPoints;
  final int currentTime;
  final double maxRippleSize;
  final int waveDuration;
  final double blurSigma;

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
    final rect = Rect.fromCircle(center: center, radius: rippleSize);
    final shadowRect = rect.shift(Offset(2, 2));
    final lightRect = rect.shift(Offset(-2, -2));

    Path shadow = Path()..addOval(shadowRect);
    Path light = Path()..addOval(lightRect);

    canvas.drawPath(shadow, shadowPaint);
    canvas.drawPath(light, lightPaint);
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
