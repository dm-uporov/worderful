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
  final blurOffset = const Offset(2.0, 2.0);

  final lightColor = Colors.grey.shade300;
  final mainColor = Colors.grey.shade400;
  final darkColor = Colors.grey.shade500;

  @override
  Widget build(BuildContext context) {
    Offset lightOffset = Offset(
      -pressProgress * blurOffset.dx,
      -pressProgress * blurOffset.dy,
    );
    Offset darkOffset = Offset(
      pressProgress * blurOffset.dx,
      pressProgress * blurOffset.dy,
    );

    final gradientOpacity = 1.0 - (pressProgress.abs() * 0.2);
    final colors = pressProgress > 0
        ? [
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              lightColor,
            ),
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              darkColor,
            ),
          ]
        : [
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              darkColor,
            ),
            Color.alphaBlend(
              mainColor.withOpacity(gradientOpacity),
              lightColor,
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
