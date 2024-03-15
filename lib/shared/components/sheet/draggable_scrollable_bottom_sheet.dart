import 'package:flavorful/shared/components/sheet/bottom_sheet_handle.dart';
import 'package:flavorful/shared/components/tappable/variants/bouncing_tappable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DraggableScrollableBottomSheet extends StatelessWidget {
  final Widget Function(BuildContext, ScrollController) builder;

  const DraggableScrollableBottomSheet({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 0.9,
        snap: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(children: [
            BouncingTappable(
                child: const BottomSheetHandle(),
                onPressed: () => context.pop()),
            Expanded(child: builder(context, scrollController))
          ]);
        });
  }
}
