import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class FadeInOutShader extends StatelessWidget {
  final Widget? child;

  const FadeInOutShader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      shaderCallback: (Rect rect) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0,
            0.25,
            0.25,
            0.75,
            0.75,
            1
          ],
          colors: [
            design.kWhite,
            design.kWhite.withOpacity(0.3),
            Colors.transparent,
            Colors.transparent,
            design.kWhite.withOpacity(0.3),
            design.kWhite
          ]).createShader(rect),
      child: child,
    );
  }
}
