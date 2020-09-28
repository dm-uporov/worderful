import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'RipplePainter.dart';

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
          WAVE_DURATION,
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
