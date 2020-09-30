import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/BrightIcon.dart';
import 'package:words_remember/utils/NeumorphicClickableContainer.dart';
import 'dart:ui';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeumorphicClickableContainer(
            childBuilder: (pressProgress) => _writingWidget(pressProgress),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              Navigator.pushNamed(context, '/training/writing');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          NeumorphicClickableContainer(
            childBuilder: (pressProgress) => _listeningWidget(pressProgress),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              // Navigator.pushNamed(context, '/training/writing');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          NeumorphicClickableContainer(
            childBuilder: (pressProgress) => _speakingWidget(pressProgress),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              // Navigator.pushNamed(context, '/training/writing');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          NeumorphicClickableContainer(
            childBuilder: (pressProgress) => _selectWidget(pressProgress),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              // Navigator.pushNamed(context, '/training/select');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          NeumorphicClickableContainer(
            childBuilder: (pressProgress) => _testWidget(pressProgress),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              // Navigator.pushNamed(context, '/training/writing');
            },
          ),
        ],
      ),
    );
  }

  Widget _writingWidget(double pressProgress) {
    return _menuButton(
      pressProgress,
      (elementsColor, accentColor) => _menuRow(
        Icons.edit_outlined,
        'Писать',
        elementsColor,
        accentColor,
      ),
    );
  }

  Widget _speakingWidget(double pressProgress) {
    return _menuButton(
      pressProgress,
      (elementsColor, accentColor) => _menuRow(
        Icons.mic,
        'Говорить',
        elementsColor,
        accentColor,
      ),
    );
  }

  Widget _listeningWidget(double pressProgress) {
    return _menuButton(
      pressProgress,
      (elementsColor, accentColor) => _menuRow(
        Icons.headset_mic_outlined,
        'Слушать',
        elementsColor,
        accentColor,
      ),
    );
  }

  Widget _selectWidget(double pressProgress) {
    return _menuButton(
      pressProgress,
      (elementsColor, accentColor) => _menuRow(
        Icons.grid_view,
        'Выбрать вариант',
        elementsColor,
        accentColor,
      ),
    );
  }

  Widget _testWidget(double pressProgress) {
    return _menuButton(
      pressProgress,
      (elementsColor, accentColor) => _menuRow(
        Icons.list_alt,
        'Викторина',
        elementsColor,
        accentColor,
      ),
    );
  }

  Widget _menuButton(double pressProgress, MenuRowBuilder menuRowBuilder) {
    final solidColorEvaluated = solidColor.withOpacity(1 - pressProgress);
    final accentColorEvaluated = cycleBlueAccent.withOpacity(pressProgress);

    final elementsColor = Color.alphaBlend(
      solidColorEvaluated,
      accentColorEvaluated,
    );
    final bottomMaxPadding = 3.0;
    final bottomPadding = pressProgress * bottomMaxPadding;
    return Container(
      width: 240,
      height: 60,
      padding: EdgeInsets.only(left: 16, bottom: bottomPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: menuRowBuilder.call(elementsColor, accentColorEvaluated),
      ),
    );
  }

  List<Widget> _menuRow(
    IconData icon,
    String title,
    Color elementsColor,
    Color accentColor,
  ) {
    return [
      Padding(padding: EdgeInsets.only(left: 8.0)),
      BrightIcon(
        icon: icon,
        solidColor: elementsColor,
        brightnessColor: accentColor,
      ),
      Padding(padding: EdgeInsets.only(left: 8.0)),
      Text(
        title,
        style: TextStyle(
          color: elementsColor,
          shadows: [Shadow(color: accentColor, blurRadius: 5)],
        ),
      ),
    ];
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}

typedef MenuRowBuilder = List<Widget> Function(
  Color elementsColor,
  Color accentColor,
);
