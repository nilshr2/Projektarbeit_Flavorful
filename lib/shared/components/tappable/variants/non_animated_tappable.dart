import 'package:flutter/material.dart';

class NonAnimatedTappable extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;

  const NonAnimatedTappable(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double distance = 0.0;
    return Listener(
      onPointerMove: (PointerMoveEvent event) {
        distance += event.delta.distanceSquared;
      },
      onPointerDown: (PointerDownEvent event) {
        distance = 0.0;
      },
      onPointerUp: (PointerUpEvent event) {
        if (distance < 10) {
          onPressed();
        }
      },
      child: child,
    );
  }
}
