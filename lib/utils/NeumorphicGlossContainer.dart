import 'package:flutter/material.dart';

typedef OnTapCallback = void Function(Offset point);

class NeumorphicGlossContainer extends StatelessWidget {
  NeumorphicGlossContainer({
    Key key,
    this.child,
    this.radius = 5.0,
    this.pressProgress,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final double pressProgress;

  final bevel = 5.0;

  final lightColor = Colors.grey.shade800;
  final mainColor = Colors.grey.shade900;
  final darkColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final blurSigma = 2.0;
    final blurOffset = blurSigma * ((pressProgress * 2) - 1);

    final lightOffset = Offset(blurOffset, blurOffset);
    final darkOffset = Offset(-blurOffset, -blurOffset);

    final gradientOpacity = 1.0 - (pressProgress.abs() * 0.05);
    final colors = pressProgress > 0
        ? [
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              darkColor,
            ),
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              lightColor,
            ),
          ]
        : [
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              lightColor,
            ),
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              darkColor,
            ),
          ];

    return Container(
      width: 200,
      padding: EdgeInsets.all(16.0),
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.grey.shade400,
        boxShadow: [
          BoxShadow(
            blurRadius: bevel * pressProgress.abs(),
            offset: lightOffset,
            color: lightColor,
          ),
          BoxShadow(
            blurRadius: bevel * pressProgress.abs(),
            offset: darkOffset,
            color: darkColor,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}
