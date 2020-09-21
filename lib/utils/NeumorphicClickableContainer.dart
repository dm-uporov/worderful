import 'package:flutter/material.dart';
import 'package:words_remember/utils/NeumorphicGlossContainer.dart';
import 'package:words_remember/utils/NeumorphicRubberContainer.dart';

typedef OnTapCallback = void Function(Offset point);

enum NeumorphicType { GLOSS, RUBBER }

class NeumorphicClickableContainer extends StatefulWidget {
  const NeumorphicClickableContainer({
    Key key,
    this.child,
    this.type = NeumorphicType.GLOSS,
    this.radius = 5.0,
    this.onTapDown,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final OnTapCallback onTapDown;
  final GestureTapCallback onTap;
  final NeumorphicType type;

  @override
  _NeumorphicClickableContainerState createState() =>
      _NeumorphicClickableContainerState();
}

class _NeumorphicClickableContainerState
    extends State<NeumorphicClickableContainer> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: pressed ? 1.0 : -1.0,
        end: pressed ? -1.0 : 1.0,
      ),
      curve: Curves.easeOutCubic,
      duration: Duration(milliseconds: 300),
      builder: (context, value, child) {
        return GestureDetector(
          onTapDown: (details) {
            setState(() {
              if (widget.onTapDown != null) {
                widget.onTapDown(details.globalPosition);
              }
              pressed = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              pressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              pressed = false;
            });
          },
          onTap: widget.onTap,
          child: createWidget(value),
        );
      },
    );
  }

  Widget createWidget(double pressProgress) {
    switch (widget.type) {
      case NeumorphicType.GLOSS:
        return NeumorphicGlossContainer(
          radius: widget.radius,
          child: widget.child,
          pressProgress: pressProgress,
        );
      case NeumorphicType.RUBBER:
        return NeumorphicRubberContainer(
          radius: widget.radius,
          child: widget.child,
          pressProgress: pressProgress,
        );
      default:
        throw Exception("Unknown type of neumorphic widget");
    }
  }
}
