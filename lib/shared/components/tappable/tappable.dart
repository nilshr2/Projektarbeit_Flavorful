import 'package:flavorful/shared/components/tappable/variants/adaptive_tappable.dart';
import 'package:flavorful/shared/components/tappable/variants/non_animated_tappable.dart';
import 'package:flutter/material.dart';

import 'variants/bouncing_tappable.dart';

class Tappable extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child;
  final Color backgroundColor;
  final double? pressedOpacityCupertino;
  final Color? splashColorMaterial;
  final Color? highlightColorMaterial;
  final bool useAdaptiveTappable;
  final bool showAnimation;

  const Tappable(
      {super.key,
      required this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.pressedOpacityCupertino = 0.4,
      this.splashColorMaterial,
      this.highlightColorMaterial,
      this.useAdaptiveTappable = false,
      this.showAnimation = true});

  @override
  Widget build(BuildContext context) {
    if (!showAnimation) {
      return NonAnimatedTappable(onPressed: onTap, child: child);
    }
    if (!useAdaptiveTappable) {
      return BouncingTappable(onPressed: onTap, child: child);
    }
    return AdaptiveTappable(
      onTap: onTap,
      backgroundColor: backgroundColor,
      pressedOpacityCupertino: pressedOpacityCupertino,
      highlightColorMaterial: highlightColorMaterial,
      splashColorMaterial: splashColorMaterial,
      child: child,
    );
  }
}
