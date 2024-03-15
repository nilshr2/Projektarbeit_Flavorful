import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

import 'nested_components/positioned_image.dart';
import 'nested_components/recipe_actions.dart';
import 'nested_components/recipe_information.dart';

class RecipeHeader extends StatelessWidget {
  final Recipe recipe;
  final double imageHeight;
  final double imageOffset;
  final void Function(int recipeId, double factor) nav;

  const RecipeHeader({
    super.key,
    required this.recipe,
    required this.imageHeight,
    required this.imageOffset,
    required this.nav,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            RecipeInformation(
              recipe: recipe,
              imageHeight: imageHeight,
              imageOffset: imageOffset,
            ),
            PositionedImage(
                imageOffset: imageOffset,
                imageHeight: imageHeight,
                recipe: recipe),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(design.kNormalInset),
          child: RecipeActions(
            recipe: recipe,
            nav: nav,
          ),
        ),
      ],
    );
  }
}
