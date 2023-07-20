import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double defaultHeight = constraint.maxHeight;
        double radius = 150;
        return Stack(
          children: [
            Positioned(
                top: -radius, left: -radius, child: renderBlurCircle(radius)),
            Positioned(
                top: defaultHeight * 0.9 - radius,
                right: -radius,
                child: renderBlurCircle(radius)),
            Positioned.fill(child: child)
          ],
        );
      },
    );
  }

  Widget renderBlurCircle(radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          colors: [
            Color(0x80008680),
            Color(0x00008680),
          ],
        ),
      ),
    );
  }
}
