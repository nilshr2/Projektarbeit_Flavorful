import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class PositionedImage extends StatelessWidget {
  final double imageOffset;
  final double imageHeight;
  final Recipe recipe;

  const PositionedImage({
    super.key,
    required this.imageOffset,
    required this.imageHeight,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    DecorationImage? image = getRecipeImage();

    return Positioned(
      right: -imageOffset,
      top: 0,
      child: Container(
        width: imageHeight,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, border: design.kLargeImageBorder),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: image,
              color: design.kAccent,
            ),
          ),
        ),
      ),
    );
  }

  DecorationImage? getRecipeImage() {
    return recipe.imageUrl != null
        ? DecorationImage(image: NetworkImage(recipe.imageUrl ?? ""))
        : null;
  }
}
