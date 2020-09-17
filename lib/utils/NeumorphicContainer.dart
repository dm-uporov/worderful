import 'package:flutter/material.dart';

class NeumorphicContainer extends StatefulWidget {
  const NeumorphicContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState(child);
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  _NeumorphicContainerState(this.child);

  final Widget child;

  final bevel = 5.0;
  final blurOffset = Offset(2.0, 2.0);

  final lightColor = Colors.grey.shade300;
  final mainColor = Colors.grey.shade400;
  final darkColor = Colors.grey.shade500;

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: pressed ? 1.0 : 0.0,
        end: pressed ? 0.0 : 1.0,
      ),
      curve: Curves.easeOutCubic,
      duration: Duration(milliseconds: 200),
      builder: (context, value, child) {
        return GestureDetector(
          onTapDown: (details) {
            setState(() {
              pressed = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              pressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              pressed = false;
            });
          },
          child: createWidget(value),
        );
      },
    );
  }

  Widget createWidget(double shadowCoefficient) {
    Offset lightOffset = Offset(
      -shadowCoefficient * blurOffset.dx,
      -shadowCoefficient * blurOffset.dy,
    );
    Offset darkOffset = Offset(
      shadowCoefficient * blurOffset.dx,
      shadowCoefficient * blurOffset.dy,
    );

    final gradientOpacity = 1.0 - (shadowCoefficient.abs() * 0.2);
    final colors = shadowCoefficient > 0
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
      padding: EdgeInsets.all(16.0),
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bevel),
        color: Colors.grey.shade400,
        boxShadow: [
          BoxShadow(blurRadius: bevel * shadowCoefficient, offset: lightOffset, color: lightColor),
          BoxShadow(blurRadius: bevel * shadowCoefficient, offset: darkOffset, color: darkColor)
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
