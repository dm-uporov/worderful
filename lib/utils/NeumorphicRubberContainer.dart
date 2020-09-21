import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';

typedef OnTapCallback = void Function(Offset point);

class NeumorphicRubberContainer extends StatelessWidget {
  const NeumorphicRubberContainer({
    Key key,
    this.child,
    this.radius = 40.0,
    /// from -1.0 (pressed) to 1.0 (normal)
    this.pressProgress = 1.0,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final double pressProgress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeumorphicPaint(
        radius: Radius.circular(radius),
        pressProgress: pressProgress,
      ),
      child: child,
    );
  }
}

class _NeumorphicPaint extends CustomPainter {
  _NeumorphicPaint({
    this.radius = const Radius.circular(0),
    this.pressProgress,
  });

  static const blurSigma = 3.0;
  static const mainFrameBlurSigma = 2.0;

  final Radius radius;
  final double pressProgress;

  final Paint mainPaint = Paint()
    ..color = backgroundColor
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, mainFrameBlurSigma);
  final Paint shadowPaint = Paint()
    ..color = darken(backgroundColor)
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
  final Paint lightPaint = Paint()
    ..color = lighten(backgroundColor)
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, radius);

    final lightRRect = rRect.shift(Offset(-blurSigma * pressProgress, -blurSigma * pressProgress));
    final shadowRRect = rRect.shift(Offset(blurSigma * pressProgress, blurSigma * pressProgress));

    canvas.drawRRect(lightRRect, lightPaint);
    canvas.drawRRect(shadowRRect, shadowPaint);
    canvas.drawRRect(rRect, mainPaint);
  }

  @override
  bool shouldRepaint(_NeumorphicPaint oldDelegate) {
    return radius != oldDelegate.radius || pressProgress != oldDelegate.pressProgress;
  }
}
