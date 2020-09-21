import 'package:flutter/material.dart';
import 'package:words_remember/utils/NeumorphicClickableContainer.dart';
import 'package:words_remember/utils/NeumorphicRipplesObservableBoard.dart';
import 'dart:ui';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  TouchPoint point;
  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // RaisedButton(
          //   child: Text('Написание'),
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/training/writing');
          //   },
          // ),
          // Padding(padding: EdgeInsets.only(top: 40.0)),
          // NeumorphicContainer(
          //   child: Text(
          //     "Neumorphic",
          //     style: TextStyle(fontSize: 32.0, color: Colors.grey.shade500),
          //   ),
          // ),
          // Padding(padding: EdgeInsets.only(top: 40.0)),
          NeumorphicClickableContainer(
            child: _writingWidget(),
            type: NeumorphicType.RUBBER,
            radius: 40.0,
            onTap: () {
              Navigator.pushNamed(context, '/training/writing');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          NeumorphicClickableContainer(
            key: buttonKey,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: Colors.grey.shade600,
                ),
                Padding(padding: EdgeInsets.only(left: 8.0)),
                Text(
                  'Написание',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            radius: 100,
            onTap: () {
              Navigator.pushNamed(context, '/training/writing');
            },
          ),
        ],
      ),
    );
  }

  Widget _writingWidget() {
    return Container(
      width: 200,
      height: 54,
      padding: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit_outlined,
            color: Colors.grey.shade600,
          ),
          Padding(padding: EdgeInsets.only(left: 8.0)),
          Text(
            'Написание',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}
