import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

class NeomorphicRipplesBoard extends StatefulWidget {
  @override
  _NeomorphicRipplesBoardState createState() => _NeomorphicRipplesBoardState();
}

class _NeomorphicRipplesBoardState extends State<NeomorphicRipplesBoard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<Widget> ripples = [];
  List<Widget> finished = [];
  List<TouchPoint> points = [];
  int _animationTime = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(days: 365),
      vsync: this,
    );

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Tween(begin: 0.0, end: double.infinity).animate(controller)
      ..addListener(() {
        setState(() {
          _animationTime = DateTime.now().millisecondsSinceEpoch;
        });
      });

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          points.add(TouchPoint(details.localPosition, _animationTime));
        });
      },
      child: Container(
        color: Colors.grey.shade400,
        width: width,
        height: height,
        child: CustomPaint(
          painter: RipplePainter(
            points,
            _animationTime,
            height,
          ),
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  static const int waveDuration = 3000;

  RipplePainter(
      List<TouchPoint> touchPoints, this.currentTime, this.maxRippleSize)
      : this.touchPoints = touchPoints
            .where((element) => currentTime - element.fromTime < waveDuration)
            .toList();

  final List<TouchPoint> touchPoints;
  final int currentTime;
  final double maxRippleSize;

  final Paint ripplePaint = Paint()
    ..color = Colors.grey.shade400
    ..strokeWidth = 5.0
    ..style = PaintingStyle.stroke
    ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  final Paint shadowPaint = Paint()
    ..color = Colors.grey.shade600
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  final Paint lightPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5);

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
    canvas.drawPath(path, ripplePaint);
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
