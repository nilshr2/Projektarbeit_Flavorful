import 'package:flutter/material.dart';

class BouncingTappable extends StatefulWidget {
  final Widget? child;
  final VoidCallback onPressed;

  const BouncingTappable(
      {super.key, required this.child, required this.onPressed});

  @override
  State<BouncingTappable> createState() => _BouncingTappableState();
}

class _BouncingTappableState extends State<BouncingTappable>
    with TickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late AnimationController _scaleController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 75),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.decelerate));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: _fadeController, curve: Curves.ease));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double distance = 0.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        _fadeController.forward();
      },
      onExit: (event) {
        _fadeController.reverse();
      },
      child: Listener(
        onPointerCancel: (PointerCancelEvent event) {},
        onPointerMove: (PointerMoveEvent event) {
          distance += event.delta.distanceSquared;
        },
        onPointerDown: (PointerDownEvent event) {
          distance = 0.0;
          _scaleController.forward();
        },
        onPointerUp: (PointerUpEvent event) {
          _scaleController.reverse();
          if (distance < 10) {
            widget.onPressed();
          }
        },
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
