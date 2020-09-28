import 'package:flutter/material.dart';

class NeumorphicRubberContainer extends StatelessWidget {
  const NeumorphicRubberContainer({
    Key key,
    this.child,
    this.radius = 40.0,
    this.pressProgress = 0.0,
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
    this.blurSigma = 4.0,
    this.pressProgress,
  })  : shadowPaint = Paint()
          ..color = Colors.black12.withOpacity(blurSigma / 20)//0.08)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma),
        lightPaint = Paint()
          ..color = Colors.white10.withOpacity(blurSigma / 40)//0.04)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);

  final Radius radius;
  final double pressProgress;
  final double blurSigma;

  final Paint shadowPaint;
  final Paint lightPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, radius);

    final blurOffset = blurSigma * ((pressProgress * 2) - 1);
    final lightRRect = rRect.shift(Offset(blurOffset, blurOffset));
    final shadowRRect = rRect.shift(Offset(-blurOffset, -blurOffset));

    canvas.drawDRRect(rRect, lightRRect.deflate(blurSigma), shadowPaint);
    canvas.drawDRRect(rRect, shadowRRect.deflate(blurSigma), lightPaint);
  }

  @override
  bool shouldRepaint(_NeumorphicPaint oldDelegate) {
    return radius != oldDelegate.radius ||
        pressProgress != oldDelegate.pressProgress ||
        blurSigma != oldDelegate.blurSigma;
  }
}
