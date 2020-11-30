import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:words_remember/resources/colors.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradientDecoration,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
