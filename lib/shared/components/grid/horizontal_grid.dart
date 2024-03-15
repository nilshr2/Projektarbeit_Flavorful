import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

///Horizontal grid that mimics the calculations of a vertical grid in
///order to maintain a consistent child size across the app.
class HorizontalGrid extends StatelessWidget {
  final double maxExtent;
  final int crossAxisCount;
  final double childAspectRatio;
  final double childCrossAxisAddedPx;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const HorizontalGrid(
      {super.key,
      required this.maxExtent,
      required this.crossAxisCount,
      this.childAspectRatio = 1,
      this.childCrossAxisAddedPx = 0,
      required this.itemBuilder,
      required this.itemCount,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //Calculates the width/height of an item.
      int tiles = (constraints.maxWidth / maxExtent).floor() + 1;
      double availablePx =
          constraints.maxWidth - (mainAxisSpacing * (tiles - 1));
      double extent = availablePx / tiles;
      double crossAxisExtent = extent * crossAxisCount;

      return SizedBox(
        height: crossAxisExtent / childAspectRatio +
            (crossAxisCount * childCrossAxisAddedPx) +
            ((crossAxisCount - 1) * crossAxisSpacing),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverAlignedGrid(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount),
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: extent,
                  child: itemBuilder(context, index),
                );
              },
              itemCount: itemCount, //category.recipeIds.length,
            ),
          ],
        ),
      );
    });
  }
}
