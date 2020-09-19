import 'package:flutter/material.dart';
import 'package:words_remember/utils/NeumorphicRipplesBoard.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return NeomorphicRipplesBoard();
  }
}
