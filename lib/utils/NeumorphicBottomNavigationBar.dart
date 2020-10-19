import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';

import 'BrightIcon.dart';
import 'container/NeumorphicContainer.dart';
import 'container/NeumorphicSelectableContainer.dart';

class NeumorphicBottomNavigationBar extends StatefulWidget {
  NeumorphicBottomNavigationBar({
    Key key,
    this.items,
    this.onTap,
    this.selected = 0,
  }) : super(key: key);

  final List<NeumorphicBottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int selected;

  @override
  _NeumorphicBottomNavigationBarState createState() =>
      _NeumorphicBottomNavigationBarState(selected);
}

class _NeumorphicBottomNavigationBarState
    extends State<NeumorphicBottomNavigationBar> {
  _NeumorphicBottomNavigationBarState(this.selected);

  int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: cycleBlueDark,
      ),
      height: 72,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: itemsWidgets(),
        ),
      ),
    );
  }

  List<Widget> itemsWidgets() {
    final widgets = List<Widget>();

    for (int i = 0; i < widget.items.length; i++) {
      widgets.add(createItem(widget.items[i], i));
    }
    return widgets;
  }

  Widget createItem(NeumorphicBottomNavigationBarItem item, int index) {
    final itemIsSelected = index == selected;
    return NeumorphicSelectableContainer(
      maxUnpressedState: 0.5,
      style: NeumorphicStyle(
        radius: 8,
        blurRadius: 1,
        elevation: 0.3,
      ),
      selected: itemIsSelected,
      childBuilder: (pressProgress) {
        /// cause pressProgress here is from 0.5 to 1.0
        final normalizedProgress = pressProgress * 2 - 1;
        return Container(
          width: 54,
          height: 54,
          color: Colors.black.withOpacity(0),
          child: BrightIcon(
            icon: item.icon,
            solidColor: colorByProgress(progress: normalizedProgress),
            brightnessColor: cycleBlueAccent.withOpacity(normalizedProgress),
          ),
        );
      },
      onSelected: () {
        widget.onTap.call(index);
        setState(() {
          selected = index;
        });
      },
    );
  }
}

class NeumorphicBottomNavigationBarItem {
  NeumorphicBottomNavigationBarItem({
    @required this.icon,
    @required this.title,
  });

  final IconData icon;
  final String title;
}
