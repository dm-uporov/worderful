import 'package:flutter/material.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';

import 'NeumorphicPressableContainer.dart';

typedef WidgetBuilder = Widget Function(double pressProgress);

class NeumorphicClickableContainer extends NeumorphicPressableContainer {
  const NeumorphicClickableContainer({
    Key key,
    Widget child,
    WidgetBuilder childBuilder,
    NeumorphicStyle style = const NeumorphicStyle(),
    this.onTap,
  }) : super(
          key: key,
          child: child,
          childBuilder: childBuilder,
          style: style,
        );

  final GestureTapCallback onTap;

  @override
  _NeumorphicClickableContainerState createState() =>
      _NeumorphicClickableContainerState();
}

class _NeumorphicClickableContainerState
    extends NeumorphicPressableContainerState<NeumorphicClickableContainer> {
  _NeumorphicClickableContainerState() : super(pressed: false);

  @override
  GestureDetector createGestureDetector({
    BuildContext context,
    double value,
    Widget child,
  }) {
    return GestureDetector(
      child: child,
      onTapDown: (details) => changePressedTo(true),
      onTapUp: (details) => changePressedTo(false),
      onTapCancel: () => changePressedTo(false),
      onTap: widget.onTap,
    );
  }

  void changePressedTo(bool value) {
    if (pressed == value) return;
    setState(() {
      pressed = value;
    });
  }
}
