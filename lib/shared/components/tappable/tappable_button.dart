import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

import 'tappable.dart';

class TappableButton extends StatelessWidget {
  final VoidCallback onTap;
  final List<Widget> content;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  const TappableButton(
      {super.key,
      required this.onTap,
      required this.content,
      this.color = design.kWhite,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 48),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: design.kButtonInset),
        decoration: BoxDecoration(
            color: color,
            borderRadius: design.kSmallBorderRad,
            boxShadow: boxShadow),
        child: Row(
          mainAxisAlignment: content.length > 1
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: content,
        ),
      ),
    );
  }
}
