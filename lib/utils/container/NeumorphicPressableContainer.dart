import 'package:flutter/material.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';

typedef WidgetBuilder = Widget Function(double pressProgress);

abstract class NeumorphicPressableContainer extends StatefulWidget {
  const NeumorphicPressableContainer({
    Key key,
    this.child,
    this.childBuilder,
    this.style = const NeumorphicStyle(),
    this.pressed = false,
  }) : super(key: key);

  final Widget child;
  final WidgetBuilder childBuilder;

  final NeumorphicStyle style;
  final bool pressed;

  @protected
  @factory
  NeumorphicPressableContainerState createState();
}

abstract class NeumorphicPressableContainerState<
    T extends NeumorphicPressableContainer> extends State<T> {
  NeumorphicPressableContainerState({
    this.pressed,
    /// from 0.0 to 1.0
    this.maxUnpressedState = 0.0,
    /// from 0.0 to 1.0
    this.maxPressedState = 1.0,
  });

  bool pressed;

  final double maxUnpressedState;
  final double maxPressedState;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: pressed ? maxUnpressedState : maxPressedState,
        end: pressed ? maxPressedState : maxUnpressedState,
      ),
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      builder: (context, value, _) {
        final child = widget.child == null
            ? widget.childBuilder.call(value)
            : widget.child;
        return createGestureDetector(
          context: context,
          value: value,
          child: NeumorphicContainer(
            child: child,
            pressProgress: value,
            style: widget.style,
          ),
        );
      },
    );
  }

  @protected
  GestureDetector createGestureDetector({
    BuildContext context,
    double value,
    Widget child,
  });
}
