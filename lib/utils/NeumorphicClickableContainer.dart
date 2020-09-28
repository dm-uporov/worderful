import 'package:flutter/material.dart';
import 'package:words_remember/utils/NeumorphicGlossContainer.dart';
import 'package:words_remember/utils/NeumorphicRubberContainer.dart';

typedef WidgetBuilder = Widget Function(double pressProgress);

enum NeumorphicType { GLOSS, RUBBER }

class NeumorphicClickableContainer extends StatefulWidget {
  const NeumorphicClickableContainer({
    Key key,
    this.child,
    this.childBuilder,
    this.type = NeumorphicType.GLOSS,
    this.radius = 5.0,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final WidgetBuilder childBuilder;

  final NeumorphicType type;
  final double radius;
  final GestureTapCallback onTap;

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
        begin: pressed ? 0.0 : 1.0,
        end: pressed ? 1.0 : 0.0,
      ),
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      builder: (context, value, child) {
        return GestureDetector(
          onTapDown: (details) {
            if (pressed) return;
            setState(() {
              pressed = true;
            });
          },
          onTapUp: (details) {
            if (!pressed) return;
            setState(() {
              pressed = false;
            });
          },
          onTapCancel: () {
            if (!pressed) return;
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
    final child = widget.child == null
        ? widget.childBuilder.call(pressProgress)
        : widget.child;
    switch (widget.type) {
      case NeumorphicType.GLOSS:
        return NeumorphicGlossContainer(
          radius: widget.radius,
          child: child,
          pressProgress: pressProgress,
        );
      case NeumorphicType.RUBBER:
        return NeumorphicRubberContainer(
          radius: widget.radius,
          child: child,
          pressProgress: pressProgress,
        );
      default:
        throw Exception("Unknown type of neumorphic widget");
    }
  }
}
