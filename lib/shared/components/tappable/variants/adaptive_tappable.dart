import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveTappable extends StatefulWidget {
  final VoidCallback onTap;
  final Widget? child;
  final Color backgroundColor;
  final double? pressedOpacityCupertino;
  final Color? splashColorMaterial;
  final Color? highlightColorMaterial;

  const AdaptiveTappable(
      {super.key,
      required this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.pressedOpacityCupertino = 0.4,
      this.splashColorMaterial,
      this.highlightColorMaterial});

  @override
  State<AdaptiveTappable> createState() => _AdaptiveTappableState();
}

class _AdaptiveTappableState extends State<AdaptiveTappable>
    with SingleTickerProviderStateMixin {
  late final HSLColor hslBgColor = HSLColor.fromColor(widget.backgroundColor);

  // Eyeballed values. Feel free to tweak.
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(AdaptiveTappable old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacityCupertino ?? 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _pressedDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_pressedDown) {
      _pressedDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_pressedDown) {
      _pressedDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_pressedDown) {
      _pressedDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _pressedDown;
    final TickerFuture ticker = _pressedDown
        ? _animationController.animateTo(1.0,
            duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0,
            duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _pressedDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final HSLColor hslColor = HSLColor.fromColor(
        (widget.backgroundColor != Colors.transparent)
            ? widget.backgroundColor
            : Colors.white);

    return (kIsWeb || !Platform.isIOS)
        ? Material(
            color: widget.backgroundColor,
            child: InkWell(
              splashColor: widget.splashColorMaterial ??
                  hslColor.withLightness(hslColor.lightness - 0.1).toColor(),
              highlightColor: widget.highlightColorMaterial ??
                  hslColor.withLightness(hslColor.lightness - 0.1).toColor(),
              onTap: widget.onTap,
              child: widget.child,
            ))
        : GestureDetector(
            onTap: widget.onTap,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            behavior: HitTestBehavior.opaque,
            child: FadeTransition(
                opacity: _opacityAnimation,
                child: Material(
                  color: widget.backgroundColor,
                  child: widget.child,
                )));
  }
}
