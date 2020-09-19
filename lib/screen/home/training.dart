import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:words_remember/utils/NeumorphicContainer.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('Написание'),
            onPressed: () {
              Navigator.pushNamed(context, '/training/writing');
            },
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          NeumorphicContainer(
            child: Text(
              "Neumorphic",
              style: TextStyle(fontSize: 32.0, color: Colors.grey.shade500),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          NeumorphicContainer(
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade500,
            ),
            radius: 100,
          ),
        ],
      ),
    );
  }
}
