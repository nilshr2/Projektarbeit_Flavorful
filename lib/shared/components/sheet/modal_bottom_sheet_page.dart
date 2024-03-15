import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class BottomSheetOptions {
  final BoxConstraints? constraints;
  final Offset? anchorPoint;
  final bool isScrollControlled;

  const BottomSheetOptions({
    this.constraints,
    this.anchorPoint,
    this.isScrollControlled = false,
  });
}

class ModalBottomSheetPage<T> extends Page<T> {
  final WidgetBuilder builder;
  final BoxConstraints? constraints;
  final Offset? anchorPoint;
  final bool isScrollControlled;

  ModalBottomSheetPage(this.builder, BottomSheetOptions options)
      : constraints = options.constraints,
        anchorPoint = options.anchorPoint,
        isScrollControlled = options.isScrollControlled;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
      builder: builder,
      modalBarrierColor: design.kDarken,
      backgroundColor: Colors.transparent,
      constraints: constraints,
      anchorPoint: anchorPoint,
      isScrollControlled: isScrollControlled,
      enableDrag: true,
      useSafeArea: true,
      settings: this,
      showDragHandle: false,
      elevation: 0);
}
