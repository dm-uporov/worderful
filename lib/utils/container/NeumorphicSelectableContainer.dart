import 'package:flutter/material.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';

import 'NeumorphicPressableContainer.dart';

typedef WidgetBuilder = Widget Function(double pressProgress);

typedef OnSelected = void Function();
typedef OnUnselected = void Function();

class NeumorphicSelectableContainer extends NeumorphicPressableContainer {
  const NeumorphicSelectableContainer({
    Key key,
    Widget child,
    WidgetBuilder childBuilder,
    NeumorphicStyle style = const NeumorphicStyle(),
    this.selected = false,
    this.onSelected,
    this.onUnselected,
  }) : super(
          key: key,
          child: child,
          childBuilder: childBuilder,
          style: style,
          pressed: selected,
        );

  final bool selected;

  final OnSelected onSelected;
  final OnUnselected onUnselected;

  @override
  _NeumorphicSelectableContainerState createState() =>
      _NeumorphicSelectableContainerState(selected);
}

class _NeumorphicSelectableContainerState
    extends NeumorphicPressableContainerState<NeumorphicSelectableContainer> {
  _NeumorphicSelectableContainerState(bool selected)
      : super(
          pressed: selected,
          maxUnpressedState: 0.5,
        );

  @override
  void didUpdateWidget(NeumorphicSelectableContainer oldWidget) {
    if (widget.pressed != oldWidget.pressed) {
      setState(() {
        pressed = widget.pressed;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  GestureDetector createGestureDetector({
    BuildContext context,
    double value,
    Widget child,
  }) {
    return GestureDetector(
      child: child,
      onTapDown: (details) {
        if (pressed) {
          if (widget.onUnselected != null) {
            widget.onUnselected.call();
          }
        } else {
          if (widget.onSelected != null) {
            widget.onSelected.call();
          }
        }
      },
    );
  }
}
