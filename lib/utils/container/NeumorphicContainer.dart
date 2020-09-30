import 'package:flutter/material.dart';

class NeumorphicStyle {
  final double radius;
  final double blurRadius;

  /// from 0.0 to 1.0
  final double elevation;

  const NeumorphicStyle({
    this.radius = 40.0,
    this.blurRadius = 4.0,
    this.elevation = 0.2,
  });
}

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({
    Key key,
    this.child,
    this.pressProgress = 0.0,
    this.style = const NeumorphicStyle(),
  }) : super(key: key);

  final Widget child;
  final double pressProgress;
  final NeumorphicStyle style;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeumorphicPaint(
        style: style,
        convexFactor: (pressProgress * 2) - 1,
      ),
      child: child,
    );
  }
}

class _NeumorphicPaint extends CustomPainter {
  _NeumorphicPaint({
    NeumorphicStyle style,
    // from -1.0 to 1.0
    this.convexFactor,
  })  : radius = Radius.circular(style.radius),
        blurRadius = style.blurRadius,
        elevation = style.elevation,
        shadowPaint = Paint()
          ..color = Colors.black
              .withOpacity(convexFactor.abs() * style.elevation) // 0.2
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, style.blurRadius),
        lightPaint = Paint()
          ..color = Colors.white
              .withOpacity(convexFactor.abs() * style.elevation / 2) // 0.1
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, style.blurRadius);

  final Radius radius;
  final double convexFactor;
  final double blurRadius;
  final double elevation;

  final Paint shadowPaint;
  final Paint lightPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, radius);

    final blurOffset = blurRadius * convexFactor;
    final lightRRect = rRect.shift(Offset(blurOffset, blurOffset));
    final shadowRRect = rRect.shift(Offset(-blurOffset, -blurOffset));

    canvas.drawDRRect(rRect, lightRRect.deflate(blurRadius), shadowPaint);
    canvas.drawDRRect(rRect, shadowRRect.deflate(blurRadius), lightPaint);
  }

  @override
  bool shouldRepaint(_NeumorphicPaint oldDelegate) {
    return radius != oldDelegate.radius ||
        convexFactor != oldDelegate.convexFactor ||
        blurRadius != oldDelegate.blurRadius ||
        elevation != oldDelegate.elevation;
  }
}
