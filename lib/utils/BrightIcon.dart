import 'dart:ui';

import 'package:flutter/material.dart';

class BrightIcon extends StatelessWidget {
  const BrightIcon({
    Key key,
    this.icon,
    this.solidColor,
    this.brightnessColor,
  }) : super(key: key);

  final IconData icon;
  final Color solidColor;
  final Color brightnessColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(icon, color: brightnessColor),
        Positioned(
          width: 200,
          height: 200,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        ),
        Icon(icon, color: solidColor),
      ],
    );
  }
}
