import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

const int WAVE_DURATION = 3000;

class NeumorphicRipplesObservableBoard extends StatefulWidget {
  const NeumorphicRipplesObservableBoard({Key key, this.point, this.color})
      : super(key: key);

  final TouchPoint point;
  final Color color;

  @override
  _NeumorphicRipplesObservableBoardState createState() =>
      _NeumorphicRipplesObservableBoardState();
}

class _NeumorphicRipplesObservableBoardState
    extends State<NeumorphicRipplesObservableBoard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<TouchPoint> points = [];
  int _animationTime = DateTime.now().millisecondsSinceEpoch;

  @override
  void didUpdateWidget(NeumorphicRipplesObservableBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.point != widget.point) {
      setState(() {
        filterPoints();
        points.add(widget.point);
      });
    }
  }

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
        if (points.isEmpty) return;
        setState(() {
          _animationTime = DateTime.now().millisecondsSinceEpoch;
        });
      });
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: widget.color,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: RipplePainter(
          points,
          _animationTime,
          height,
        ),
      ),
    );
  }

  void filterPoints() {
    if (points.isEmpty) return;

    points = points
        .where((element) => _animationTime - element.fromTime < WAVE_DURATION)
        .toList();
  }
}

class RipplePainter extends CustomPainter {
  RipplePainter(this.touchPoints, this.currentTime, this.maxRippleSize);

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
      final rippleProgress = timePassed.toDouble() / WAVE_DURATION.toDouble();
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
