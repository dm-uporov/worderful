import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';

import 'RipplePainter.dart';

const int WAVE_DURATION = 3000;

class NeumorphicRipplesBoard extends StatefulWidget {
  @override
  _NeumorphicRipplesBoardState createState() => _NeumorphicRipplesBoardState();
}

class _NeumorphicRipplesBoardState extends State<NeumorphicRipplesBoard>
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
          filterPoints();
          points.add(TouchPoint(details.localPosition, _animationTime));
        });
      },
      child: Container(
        width: width,
        height: height,
        child: CustomPaint(
          painter: RipplePainter(
            points,
            _animationTime,
            height,
            WAVE_DURATION
          ),
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