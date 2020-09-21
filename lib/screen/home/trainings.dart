import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/NeumorphicClickableContainer.dart';
import 'dart:ui';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final GlobalKey buttonKey = GlobalKey();

  var isWritingButtonsPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeumorphicClickableContainer(
            child: Container(
              width: 200,
              height: 54,
              padding: EdgeInsets.only(left: 16),
              child: _writingWidget(),
            ),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              Navigator.pushNamed(context, '/training/writing');
            },
            onTapDown: (_) {
              setState(() {
                isWritingButtonsPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                isWritingButtonsPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                isWritingButtonsPressed = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _writingWidget() {
    final elementsColor = isWritingButtonsPressed ? accentColor : solidColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.edit_outlined,
          color: elementsColor,
        ),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        Text(
          'Написание',
          style: TextStyle(color: elementsColor),
        ),
      ],
    );
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}
