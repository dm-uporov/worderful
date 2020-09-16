import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
